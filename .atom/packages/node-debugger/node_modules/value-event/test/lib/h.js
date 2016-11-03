var document = require("global/document")

module.exports = h

function h(tagName, props, children) {
    var elem = document.createElement(tagName)
    props = props || {}

    for (var k in props) {
        elem[k] = props[k]
    }

    if (children) {
        children.forEach(function (child) {
            elem.appendChild(child)
        })
    }
    return elem
}
