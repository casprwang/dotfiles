'use babel';

import TernView from './atom-ternjs-view';

class RenameView extends TernView {

  createdCallback() {

    this.classList.add('atom-ternjs-rename');

    const container = document.createElement('div');
    const wrapper = document.createElement('div');

    let title = document.createElement('h1');
    title.innerHTML = 'Rename';

    let sub = document.createElement('h2');
    sub.innerHTML = 'Rename a variable in a scope-aware way. (experimental)';

    let buttonClose = document.createElement('button');
    buttonClose.innerHTML = 'Close';
    buttonClose.id = 'close';
    buttonClose.classList.add('btn');
    buttonClose.classList.add('atom-ternjs-rename-close');

    buttonClose.addEventListener('click', (e) => {

      this.model.hide();
    });

    this.nameEditor = document.createElement('atom-text-editor');
    this.nameEditor.setAttribute('mini', true);
    this.nameEditor.addEventListener('core:confirm', this.rename.bind(this));

    let buttonRename = document.createElement('button');
    buttonRename.innerHTML = 'Rename';
    buttonRename.id = 'close';
    buttonRename.classList.add('btn');
    buttonRename.classList.add('mt');
    buttonRename.addEventListener('click', this.rename.bind(this));

    wrapper.appendChild(title);
    wrapper.appendChild(sub);
    wrapper.appendChild(this.nameEditor);
    wrapper.appendChild(buttonClose);
    wrapper.appendChild(buttonRename);
    container.appendChild(wrapper);

    this.appendChild(container);
  }

  rename() {

    const text = this.nameEditor.getModel().getBuffer().getText();

    if (!text) {

      return;
    }

    this.model.updateAllAndRename(text);
  }
}

module.exports = document.registerElement('atom-ternjs-rename', {

  prototype: RenameView.prototype
});
