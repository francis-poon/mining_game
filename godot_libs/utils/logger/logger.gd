class_name Logger

static func fatal(msg: String):
	print("Fatal: " + msg)

static func error(msg: String):
	if LoggerConfig.log_level < LoggerConfig.LogLevel.ERROR:
		return
	print("Error: " + msg)

static func warn(msg: String):
	if LoggerConfig.log_level < LoggerConfig.LogLevel.WARN:
		return
	print("Warn: " + msg)

static func info(msg: String):
	if LoggerConfig.log_level < LoggerConfig.LogLevel.INFO:
		return
	print("Info: " + msg)

static func debug(msg: String):
	if LoggerConfig.log_level < LoggerConfig.LogLevel.DEBUG:
		return
	print("Debug: " + msg)

static func trace(msg: String):
	if LoggerConfig.log_level < LoggerConfig.LogLevel.TRACE:
		return
	print("Trace: " + msg)
