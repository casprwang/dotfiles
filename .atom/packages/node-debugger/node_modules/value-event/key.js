var BaseEvent = require('./base-event.js');

module.exports = BaseEvent(keyLambda);

function keyLambda(ev, broadcast) {
    var key = this.opts.key;

    if (ev.keyCode === key) {
        if (this.opts.preventDefault && ev.preventDefault) {
            ev.preventDefault();
        }

        broadcast(this.data);
    }
}
