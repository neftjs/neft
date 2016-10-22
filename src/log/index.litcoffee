# Log

Access it with:
```javascript
const { log } = Neft;
```

    'use strict'

    utils = require 'src/utils'
    assert = require 'src/assert'

    {bind} = Function
    {isArray} = Array
    {unshift} = Array::

    linesPrefix = ''

    fromArgs = (args) ->
        str = ''
        str += "#{arg} → " for arg in args
        str = str.substring 0, str.length - 3

        lines = str.split '\n'
        str = ''
        for line in lines
            str += "#{linesPrefix}#{line}\n"
        str = str.slice 0, -1

        str

    callOnce = do ->
        usedMessages = Object.create null
        ->
            msg = fromArgs arguments
            if usedMessages[msg]
                return -1
            usedMessages[msg] = true
            @ arguments...

## **Class** Log

    class Log
        @LOGS_METHODS = ['log', 'info', 'warn', 'error', 'time', 'ok']

        @TIMES_LEN = 50

        @MARKERS =
            white: (str) -> "LOG: #{str}"
            green: (str) -> "OK: #{str}"
            gray: (str) -> "#{str}"
            blue: (str) -> "INFO: #{str}"
            yellow: (str) -> "WARN: #{str}"
            red: (str) -> "ERROR: #{str}"

        @setGlobalLinesPrefix = (prefix) ->
            linesPrefix = prefix

        @time = Date.now
        @timeDiff = (since) -> Log.time() - since
        @times = new Array Log.TIMES_LEN

        for _, i in @times
            @times[i] = [0, '']

        constructor: (prefixes = [], @parentScope) ->
            @prefixes = prefixes
            assert.isArray prefixes

            # bind all logs methods
            args = utils.clone(prefixes)
            args.unshift @

            for name in @constructor.LOGS_METHODS
                @[name] = bind.apply @[name], args
                @[name].once = callOnce

            @[key] = value for key, value of @
            if typeof @['lo' + 'g'] is 'function'
                func = =>
                    @log.apply func, arguments
                func.once = callOnce
                func.constructor = @constructor
                return utils.merge func, @

        _write: console?['lo' + 'g'].bind(console) or (->)
        _writeError: console?['erro' + 'r'].bind(console) or (->)

### *Integer* log.LOG

### *Integer* log.INFO

### *Integer* log.OK

### *Integer* log.WARN

### *Integer* log.ERROR

### *Integer* log.TIME

### *Integer* log.ALL

        i = 0
        LOG: 1<<i++
        INFO: 1<<i++
        OK: 1<<i++
        WARN: 1<<i++
        ERROR: 1<<i++
        TIME: 1<<i++
        ALL: (1<<i++) - 1

### *Integer* enabled = log.ALL

Bitmask of the `log.LOG`, `INFO`, `OK`, `WARN`, `ERROR` and `TIME`.

        enabled: @::ALL

        isEnabled = (log, type) ->
            unless log.enabled & type
                false
            else if log.parentScope
                isEnabled log.parentScope, type
            else
                true

### log([*Any* messages...])

Prints the given messages into the console.

```javascript
log("Log me now!");

log("setName()", "db time");
// will be logged as "setName() → db time"
```

        @::['log'] = ->
            if isEnabled(@, @LOG)
                @_write @constructor.MARKERS.white fromArgs arguments
            return

### log.info([*Any* messages...])

Prints the given messages into the console with a blue color.

        info: ->
            if isEnabled(@, @INFO)
                @_write @constructor.MARKERS.blue fromArgs arguments
            return

### log.ok([*Any* messages...])

Prints the given messages into the console with a green color.

```javascript
log.ok("Data has been successfully sent!");
```

        ok: ->
            if isEnabled(@, @OK)
                @_write @constructor.MARKERS.green fromArgs arguments
            return

### log.warn([*Any* messages...])

Prints the given messages into the console with a yellow color.

```javascript
log.warn("Example warning with some recommendations");
```

        warn: ->
            if isEnabled(@, @WARN)
                @_write @constructor.MARKERS.yellow fromArgs arguments
            return

### log.error([*Any* messages...])

Prints the given messages into the console with a red color.

```javascript
log.error("Error occurs, ... in file ...");
```

        error: ->
            if isEnabled(@, @ERROR)
                @_writeError @constructor.MARKERS.red fromArgs arguments
            return

### *Integer* log.time()

Returns an id used to measure execution time by the `log.end()` function.

```javascript
function findPath(){
  var logtime = log.time('findPath()');

  // ... some complex algorithm ...

  log.end(logtime);
}

findPath();
```

        time: ->
            unless isEnabled(@, @TIME)
                return -1

            {times} = @constructor

            # get time id and set current time
            for v, i in times when not v[0]
                id = i
                times[i][0] = @constructor.time()
                times[i][1] = fromArgs arguments
                break

            assert id?, 'Log times out of range'

            id

### log.end(*Integer* id)

Prints an information about the execution time for the given timer id.

        end: (id) ->
            if id is -1
                return

            time = @constructor.times[id]
            diff = @constructor.timeDiff time[0]
            diff = diff.toFixed 2

            str = "#{time[1]}: #{diff} ms"
            @_write @constructor.MARKERS.gray str

            time[0] = 0
            return

### log.scope([*Any* names...])

Returns a new `log` function.

All prints will be prefixed by the given names.

```javascript
var log = log.scope("Example file");

log("hello");
// "Example file → hello"
```

        scope: (args...) ->
            if @prefixes
                unshift.apply args, @prefixes

            new @constructor args, @

    # implementation
    impl = switch true
        when utils.isNode
            require './impls/node/index.coffee'
        when utils.isBrowser
            require './impls/browser/index.coffee'

    LogImpl = if typeof impl is 'function' then impl Log else Log
    exports = module.exports = new LogImpl
    exports.Log = Log
