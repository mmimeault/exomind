

import { Exocore, MutationBuilder } from 'exocore';
import { exomind } from '../../../protos';
import * as _ from 'lodash';
import React from 'react';
import { EntityTrait, EntityTraits } from '../../../store/entities';
import EditableText from '../../interaction/editable-text/editable-text.js';
import HtmlEditorControls from '../../interaction/html-editor/html-editor-controls';
import HtmlEditor, { EditorCursor } from '../../interaction/html-editor/html-editor';
import { SelectedItem, Selection } from '../entity-list/selection';
import './note.less';

interface IProps {
    entity: EntityTraits;
    noteTrait: EntityTrait<exomind.base.INote>;

    selection?: Selection;
    onSelectionChange?: (sel: Selection) => void;
}

interface IState {
    savedNote: exomind.base.INote;
    currentNote: exomind.base.INote;
    editor?: HtmlEditor;
    cursor?: EditorCursor;
}

export default class Note extends React.Component<IProps, IState> {
    private mounted = true;

    constructor(props: IProps) {
        super(props);

        this.state = {
            savedNote: props.noteTrait.message,
            currentNote: new exomind.base.Note(props.noteTrait.message),
        }
    }

    componentWillUnmount(): void {
        this.saveContent();
        this.mounted = false;
    }

    render(): React.ReactNode {
        return (
            <div className="entity-component note">
                <div className="object-summary">
                    <div className="title field"><span className="field-label">Title</span>
                        <span className="field-content">
                            <EditableText text={this.state.currentNote.title} onChange={this.handleTitleChange.bind(this)} />
                        </span>
                    </div>
                </div>

                <div className="object-body">
                    <HtmlEditorControls editor={this.state.editor} cursor={this.state.cursor} />
                    <HtmlEditor
                        content={this.state.currentNote.body}
                        placeholder="Type your note here"
                        onBound={this.handleContentBound.bind(this)}
                        onChange={this.handleContentChange.bind(this)}
                        onBlur={this.saveContent.bind(this)}
                        onCursorChange={this.handleCursorChange.bind(this)}
                        onLinkClick={this.handleLinkClick.bind(this)}
                    />
                </div>
            </div>
        );
    }

    private handleContentBound(editor: HtmlEditor): void {
        this.setState({
            editor: editor
        });
    }

    private handleTitleChange(newTitle: string): void {
        if (newTitle !== this.state.currentNote.title) {
            const note = this.state.currentNote;
            note.title = newTitle;

            this.setState({
                currentNote: note,
            });

            this.saveContent();
        }
    }

    private handleContentChange(newBody: string): void {
        if (newBody !== this.state.currentNote.body) {
            const note = this.state.currentNote;
            note.body = newBody;

            this.setState({
                currentNote: note,
            });

            // if after a second, it's still the same body, we save it (debouncing)
            setTimeout(() => {
                if (this.state.currentNote.body === newBody) {
                    this.saveContent();
                }
            }, 1000);
        }
    }

    private handleCursorChange(cursor: EditorCursor) {
        if (this.mounted) {
            this.setState({ cursor })
        }
    }

    private handleLinkClick(url: string, e: MouseEvent) {
        e.preventDefault();
        e.stopPropagation();

        if (url.startsWith('entity://')) {
            const entityId = url.replace('entity://', '');
            if (this.props.onSelectionChange) {
                this.props.onSelectionChange(new Selection(SelectedItem.fromEntityId(entityId)));
            }
        } else {
            window.open(url, '_blank');
        }
    }

    private saveContent(): void {
        if (this.state && !_.isEqual(this.state.currentNote, this.state.savedNote)) {
            const mutation = MutationBuilder
                .updateEntity(this.props.entity.entity.id)
                .putTrait(this.state.currentNote, this.props.noteTrait.id)
                .build();

            Exocore.store.mutate(mutation);

            if (this.mounted) {
                this.setState({
                    savedNote: new exomind.base.Note(this.state.currentNote),
                });
            }
        }
    }
}

