local Logger = require("logger")

Logger.configure({
    level = "TRACE",
    enableFile = true,
    filename = "app.log"
})

Logger.log("TRACE", "uwu what's this trace message?", {"idiot", "stupid"})
Logger.log("DEBUG", "uwu what's this debug message?")
Logger.log("INFO", "uwu what's this info message?")
Logger.log("NOTICE", "uwu what's this notice message?")
Logger.log("WARNING", "uwu what's this warning message?")
Logger.log("ERROR", "uwu what's this error message?")
Logger.log("CRITICAL", "Kill yourself faggot")