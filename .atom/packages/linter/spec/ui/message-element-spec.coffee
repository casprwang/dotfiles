describe 'Message Element', ->
  {Message} = require('../../lib/ui/message-element')
  filePath = __dirname + '/fixtures/file.txt'

  getMessage = (type) ->
    return {type, text: 'Some Message', filePath}
  visibleText = (element) ->
    cloned = element.cloneNode(true)
    Array.prototype.forEach.call(cloned.querySelectorAll('[hidden]'), (item) ->
      item.remove()
    )
    return cloned.textContent

  it 'works', ->
    message = getMessage('Error')
    messageElement = Message.fromMessage(message, 'Project')
    messageElement.attachedCallback()

    expect(visibleText(messageElement).indexOf(filePath) isnt -1).toBe(true)

    messageElement.updateVisibility('Line')
    expect(messageElement.hasAttribute('hidden')).toBe(true)
    message.currentLine = true
    messageElement.updateVisibility('Line')
    expect(visibleText(messageElement).indexOf(filePath) is -1).toBe(true)

  it 'plays nice with class attribute', ->
    message = getMessage('Error')
    message.class = 'Well Hello'
    messageElement = Message.fromMessage(message, 'Project')
    messageElement.attachedCallback()

    expect(messageElement.querySelector('.Well') instanceof Element).toBe(true)
    expect(messageElement.querySelector('.Hello') instanceof Element).toBe(true)
    expect(messageElement.querySelector('.haha')).toBe(null)
