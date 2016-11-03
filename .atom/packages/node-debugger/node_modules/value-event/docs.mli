import { Handle } from "dom-delegator"

type EventHandler : {
    handleEvent : (DOMEvent) => void
}

type HigherEventFunction<T <: Object> : (
    (
        fn: (S) => void,
        data?: S | null,
        opts?: {
            preventDefault?: Boolean
        } & T
    ) => EventHandler) |
    (
        handle: Handle<S>,
        data?: S | null,
        opts?: {
            preventDefault?: Boolean
        } & T
    ) => Handle<DOMEvent>

value-event/click : HigherEventFunction<{
    ctrl?: Boolean,
    meta?: Boolean,
    rightClick?: Boolean
}>

value-event/value : HigherEventFunction<{}>

value-event/submit : HigherEventFunction<{}>

value-event/key : HigherEventFunction<{
    key: String
}>

value-event/event : HigherEventFunction<{}>

value-event/change : HigherEventFunction<{}>
