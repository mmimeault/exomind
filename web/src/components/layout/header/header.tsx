
import React from 'react';
import Navigation from '../../../navigation';
import Debouncer from '../../../utils/debouncer';
import Path from '../../../utils/path';
import { ColumnsConfig } from '../../pages/columns/columns-config';
import './header.less';
import { StoresContext, Stores } from '../../../store/stores';

interface IProps {
  path: Path;
}

interface IState {
  pathKeywords?: string;
  fieldKeywords: string;
  debouncedKeywords: string;
}

export class Header extends React.Component<IProps, IState> {
  static contextType = StoresContext;
  context: Stores;

  private debouncer: Debouncer;

  constructor(props: IProps) {
    super(props);

    this.debouncer = new Debouncer(200);

    const keywords = this.keywordsFromPath(props);
    this.state = {
      pathKeywords: keywords,
      fieldKeywords: keywords,
      debouncedKeywords: keywords,
    };
  }

  componentDidUpdate(prevProps: IProps): void {
    const previousPathKeywords = this.keywordsFromPath(prevProps);
    const pathKeywords = this.keywordsFromPath(this.props);

    // nothing to do if keywords didn't change in URL since last props
    if (previousPathKeywords == pathKeywords) {
      return;
    }

    // keywords from path just got updated from latest debounced keywords
    if (pathKeywords == this.state.debouncedKeywords) {
      this.setState({
        pathKeywords: pathKeywords,
      });
      return;
    }

    // keywords from path have an unexpected value, so we reset the local state
    this.setState({
      pathKeywords: pathKeywords,
      fieldKeywords: pathKeywords,
      debouncedKeywords: pathKeywords,
    });
  }

  render(): React.ReactNode {
    return (
      <nav id="header" className="navbar navbar-fixed-top">
        <div className="container-fluid">
          <div className="logo-col" onClick={this.handleLogoClick.bind(this)}>
            <span className="text">Exomind</span>
          </div>

          {this.context.session.exocoreInitialized ? this.renderSearchbox() : undefined}
        </div>
      </nav>
    );
  }

  private handleLogoClick() {
    Navigation.navigate(Navigation.pathForInbox());
  }

  private renderSearchbox() {
    return (
      <div className="search-col form-group">
        <div className="input-group">
          <span className="glyphicon glyphicon-search input-group-addon icon" />
          <input type="text" className="form-control" value={this.state.fieldKeywords} onChange={this.handleSearchChange.bind(this)} />
        </div>
      </div>
    );
  }

  private handleSearchChange(event: React.ChangeEvent<HTMLInputElement>) {
    const keywords = event.target.value;

    this.setState({
      fieldKeywords: keywords,
    });

    this.debouncer.debounce(() => {
      this.setState({
        debouncedKeywords: keywords,
      });

      // when current in search, we replace state, otherwise we push it
      const replace = !!this.state.pathKeywords;
      Navigation.navigate(Navigation.pathForSearch(keywords), replace);
    });
  }

  private keywordsFromPath(props: IProps): string {
    let keyword = '';
    if (Navigation.isColumnsPath(props.path)) {
      const config = ColumnsConfig.fromString(props.path.drop(1).toString());
      if (!config.empty && config.parts[0].isSearch) {
        keyword = config.parts[0].value;
      }
    }

    return keyword
  }
}

