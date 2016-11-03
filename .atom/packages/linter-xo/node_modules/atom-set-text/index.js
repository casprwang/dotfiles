'use strict';
module.exports = function (text, editor) {
	editor = editor || atom.workspace.getActiveTextEditor();

	if (!editor || typeof text !== 'string') {
		return;
	}

	const editorEl = atom.views.getView(editor);
	const cursorPosition = editor.getCursorBufferPosition();
	const selections = editor.getSelectedBufferRanges();
	const line = editorEl.getFirstVisibleScreenRow() + editor.displayBuffer.getVerticalScrollMargin();

	editor.setText(text);
	editor.setCursorBufferPosition(cursorPosition);
	editor.setSelectedBufferRanges(selections);

	if (editor.getScreenLineCount() > line) {
		editor.scrollToScreenPosition([line, 0]);
	}
};
