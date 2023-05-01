# lua-log

lua-log is a lightweight logging library for Lua that provides customizable logging to the console and/or a file

## Features

- Customizable log levels and tags.
- Configurable timestamp format, console and file logging options, filename, maximum file size, and console colors.
- Easy to configure and customize for your Lua applications.

## Usage

1. Import the library into your Lua application<br>
`wget https://raw.githubusercontent.com/MoleTheDev/lua-log/main/logger.lua`
2. Configure the logger by setting your desired configuration options using `Logger.configure()`.
3. Log messages using `Logger.log()` with your desired log level, message, and tags
4. Optionally, set the log level using `Logger.setLevel()` to only log messages with a certain level or higher

Example usage:

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

## Configuration

The logger can be configured using `Logger.configure()` with the following options:

| Option | Type | Description | Default |
| --- | --- | --- | --- |
| level | string | The minimum log level to log. Possible values are `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`. | `INFO` |
| enableConsole | boolean | Whether or not to log to the console. | `true` |
| enableFile | boolean | Whether or not to log to a file. | `false` |
| filename | string | The filename to log to. | `app.log` |
| maxFileSize | number | The maximum size of the log file in bytes. If the file exceeds this size, it will be cleared. | `1024 * 1024 * 10` (10 MB) |
| timestampFormat | string | The timestamp format to use. See [here](https://help.sumologic.com/docs/send-data/reference-information/time-reference/) for more information. | `%Y-%m-%d %H:%M:%S` |
| consoleColors | table | The colors to use for each log level in the console. | See `logger.lua` |

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for more information.
