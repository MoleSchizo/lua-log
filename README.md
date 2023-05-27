# lua-log

lightweight logging library for Lua that provides customizable logging to the console and/or a file

```lua
local Logger = require("logger")

Logger.configure({
    level = "TRACE",
    enableFile = true,
    filename = "app.log"
})

Logger.log("TRACE", "uwu what's this trace message?", {"idiot", "stupid"})
Logger.log("DEBUG", "uwu what's this debug message?")
```
