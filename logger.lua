local Logger = {}

-- Default configuration
local defaultConfig = {
    level = "INFO", -- Minimum level to log, messages with level below this will be ignored
    timestampFormat = "%Y-%m-%d %H:%M:%S",
    enableConsole = true,
    consoleColors = true,
    enableFile = false,
    filename = "log.txt",
    maxFileSize = 1024 * 1024 * 10, -- 10MB
    tags = {}
}

local levels = {
    TRACE = { value = 0, color = "\27[37m" }, -- White
    DEBUG = { value = 1, color = "\27[34m" }, -- Blue
    INFO = { value = 2, color = "\27[32m" }, -- Green
    NOTICE = { value = 3, color = "\27[36m" }, -- Cyan
    WARNING = { value = 4, color = "\27[33m" }, -- Yellow
    ERROR = { value = 5, color = "\27[31m" }, -- Red
    CRITICAL = { value = 6, color = "\27[35m" } -- Magenta
}

--[[
    Formats a log message with a timestamp and log level.
    @param level The log level.
    @param message The log message.
    @param tags The log tags.
    @return The formatted log message.
]]
local function formatMessage(level, message, tags)
    local timestamp = os.date(defaultConfig.timestampFormat)
    local logLevel = "[" .. level .. "]"
    local tagString = ""
    if tags then
        for i, tag in ipairs(tags) do
            tagString = tagString .. "[" .. tag .. "] "
        end
    end
    local formattedMessage = string.format("[%s] %s %s%s\n", timestamp, logLevel, tagString, message)
    return formattedMessage
end

--[[
    Logs a message to the console.
    @param level The log level.
    @param message The log message.
    @param tags The log tags.
]]
local function logToConsole(level, message, tags)
    if not defaultConfig.enableConsole then return end
    local logMessage = formatMessage(level, message, tags)
    if defaultConfig.consoleColors then
        local color = levels[level].color
        logMessage = color .. logMessage .. "\27[0m"
    end
    io.write(logMessage)
end

--[[
    Logs a message to a file.
    @param level The log level.
    @param message The log message.
    @param tags The log tags.
]]
--[[
local function logToFile(level, message, tags)
    if not defaultConfig.enableFile then return end
    local logMessage = formatMessage(level, message, tags)
    local file = io.open(defaultConfig.filename, "a")
    if file then
        file:write(logMessage)
        file:close()
    end
end
--]]
-- re write with max file size
local function logToFile(level, message, tags)
    if not defaultConfig.enableFile then return end
    local logMessage = formatMessage(level, message, tags)
    local file = io.open(defaultConfig.filename, "a")
    if file then
        local size = file:seek("end")
        if size > defaultConfig.maxFileSize then
            file:close()
            os.rename(defaultConfig.filename, defaultConfig.filename .. ".old")
            file = io.open(defaultConfig.filename, "a")
        end
        if file then
            file:write(logMessage)
            file:close()
        end
    end
end

--[[
    Checks if a log level is enabled.
    @param level The log level.
    @return True if the log level is enabled, false otherwise.
]]
local function isLevelEnabled(level)
    return levels[defaultConfig.level].value <= levels[level].value
end

--[[
    Configures the logger.
    @param config The configuration table.
]]
function Logger.configure(config)
    for key, value in pairs(config) do
        defaultConfig[key] = value
    end
end


--[[
    Logs a message.
    @param level The log level.
    @param message The log message.
    @param tags The log tags.
]]
function Logger.log(level, message, tags)
    if isLevelEnabled(level) then
        logToConsole(level, message, tags)
        logToFile(level, message, tags)
    end
end

--[[
    Sets the log level.
    @param level The log level.
]]
function Logger.setLevel(level)
    defaultConfig.level = level
end

--[[
    Gets the current log level.
    @return The current log level.
]]
function Logger.getConfig()
    return defaultConfig
end

return Logger
