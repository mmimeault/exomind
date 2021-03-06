import React from 'react';
import HtmlEditor from '../../components/interaction/html-editor/html-editor';
import PropTypes from 'prop-types';
import './ios-html-editor.less';

export default class IosHtmlEditor extends React.Component {
  static propTypes = {
    content: PropTypes.string
  };

  lastCursorY = -1;

  constructor(props) {
    super(props);

    // content is set via state because it may be empty at time in props
    // props are used message passing, not as full state
    this.state = {
      content: props.content
    }
  }

  componentDidUpdate(prevProps) {
    // if we receive an action
    if (this.props.action) {
      this.handleAction(this.props.action);
    }

    // if we receive new content and we update editor on same stack, it crashes
    setTimeout(() => {
      if (this.props.content) {
        this.setState({
          content: this.props.content
        });
      }
    });
  }

  render() {
    return (
      <HtmlEditor
        content={this.state.content}
        onBound={this.handleBound.bind(this)}
        onChange={this.handleContentChange.bind(this)}
        onCursorChange={this.handleCursorChange.bind(this)}
        onLinkClick={this.handleLinkClick.bind(this)}
      />
    );
  }

  handleBound(editor) {
    this.setState({ editor });
  }

  handleContentChange(newContent) {
    this.newContent = newContent;

    if (this.newContent === newContent) {
      sendIos({
        content: newContent
      });
    }
  }

  handleCursorChange(cursor) {
    if (cursor && cursor.rect) {
      let cursorY = cursor.rect.top;
      if (this.lastCursorY != cursorY) {
        sendIos({
          cursorY: cursorY
        });
        this.lastCursorY = cursorY
      }
    }
  }

  handleLinkClick(url, e) {
    e.preventDefault();
    e.stopPropagation();

    sendIos({
      link: url
    });
  }

  handleAction(name) {
    switch (name) {
      case 'bold':
        this.state.editor.toggleInlineStyle('BOLD');
        break;
      case 'strikethrough':
        this.state.editor.toggleInlineStyle('STRIKETHROUGH');
        break;
      case 'header-toggle':
        this.state.editor.toggleHeader();
        break;
      case 'list-ul':
        this.state.editor.toggleBlockType('unordered-list-item');
        break;
      case 'list-ol':
        this.state.editor.toggleBlockType('ordered-list-item');
        break;
      case 'indent':
        this.state.editor.indent();
        break;
      case 'outdent':
        this.state.editor.outdent();
        break;
      default:
        console.log('Unhandled action ' + name);
    }
  }
}

