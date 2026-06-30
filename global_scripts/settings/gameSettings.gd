# autoload/GameSettings.gd
extends Node

# ============= ENUMS =============
enum VSyncMode {
	DISABLED = 0,
	ENABLED = 1,
	ADAPTIVE = 2,
	MAILBOX = 3,
}

enum MaxFPS {
	UNLIMITED = 0,
	FPS_30 = 1,
	FPS_60 = 2,
	FPS_120 = 3,
	FPS_144 = 4,
	FPS_240 = 5,
}

enum ResolutionPreset {
	RES_1280_720 = 0,
	RES_1366_768 = 1,
	RES_1920_1080 = 2,
	RES_2560_1440 = 3,
}

enum ScreenModePreset {
	EXCLUSIVE_FULLSCREEN = 0,
	BORDERLESS = 1,
	WINDOWED = 2,
}

# ============= CONSTANTS & DICTS =============
const RESOLUTION_VALUES = {
	ResolutionPreset.RES_1280_720: Vector2i(1280, 720),
	ResolutionPreset.RES_1366_768: Vector2i(1366, 768),
	ResolutionPreset.RES_1920_1080: Vector2i(1920, 1080),
	ResolutionPreset.RES_2560_1440: Vector2i(2560, 1440),
}

const RESOLUTION_LABELS = {
	ResolutionPreset.RES_1280_720: "1280 x 720",
	ResolutionPreset.RES_1366_768: "1366 x 768",
	ResolutionPreset.RES_1920_1080: "1920 x 1080",
	ResolutionPreset.RES_2560_1440: "2560 x 1440",
}

const SCREEN_MODE_VALUES = {
	ScreenModePreset.EXCLUSIVE_FULLSCREEN: DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN,
	ScreenModePreset.BORDERLESS: DisplayServer.WINDOW_MODE_FULLSCREEN,
	ScreenModePreset.WINDOWED: DisplayServer.WINDOW_MODE_WINDOWED,
}

const SCREEN_MODE_LABELS = {
	ScreenModePreset.EXCLUSIVE_FULLSCREEN: "Fullscreen",
	ScreenModePreset.BORDERLESS: "Borderless",
	ScreenModePreset.WINDOWED: "Windowed",
}

const VSYNC_DIC = {
	"Disabled": VSyncMode.DISABLED,
	"Enabled": VSyncMode.ENABLED,
	"Adaptive": VSyncMode.ADAPTIVE,
	"Mailbox": VSyncMode.MAILBOX,
}

const MAX_FPS_DIC = {
	"Unlimited": MaxFPS.UNLIMITED,
	"30": MaxFPS.FPS_30,
	"60": MaxFPS.FPS_60,
	"120": MaxFPS.FPS_120,
	"144": MaxFPS.FPS_144,
	"240": MaxFPS.FPS_240,
}

const FPS_VALUES = [0, 30, 60, 120, 144, 240]

# ============= VIDEO SETTINGS =============
var vsync_mode: int = VSyncMode.MAILBOX
var max_fps: int = 60
var resolution_preset: int = ResolutionPreset.RES_1920_1080
var screen_mode: int = ScreenModePreset.EXCLUSIVE_FULLSCREEN
var is_fullscreen: bool = true

# ============= SIGNALS =============
signal settings_changed(setting_name: String, value)

# ============= LIFECYCLE =============
func _ready() -> void:
	load_settings()
	apply_all_settings()

# ============= APPLY SETTINGS =============
func apply_all_settings() -> void:
	apply_video_settings()
	apply_window_settings()

func apply_video_settings() -> void:
	DisplayServer.window_set_vsync_mode(vsync_mode)
	Engine.max_fps = max_fps

func apply_window_settings() -> void:
	DisplayServer.window_set_mode(SCREEN_MODE_VALUES[screen_mode])
	if resolution_preset in RESOLUTION_VALUES:
		_apply_resolution(resolution_preset)

func _apply_resolution(preset: int) -> void:
	var res = RESOLUTION_VALUES[preset]
	DisplayServer.window_set_size(res)
	await get_tree().process_frame
	var screen = DisplayServer.screen_get_size()
	DisplayServer.window_set_position((screen - res) / 2)

# ============= SETTERS (Called from UI) =============
func set_vsync(mode: int) -> void:
	vsync_mode = mode
	DisplayServer.window_set_vsync_mode(vsync_mode)
	settings_changed.emit("vsync", vsync_mode)
	save_settings()

func set_max_fps(fps_index: int) -> void:
	if fps_index < FPS_VALUES.size():
		max_fps = FPS_VALUES[fps_index]
		Engine.max_fps = max_fps
		settings_changed.emit("max_fps", max_fps)
		save_settings()

func set_resolution(preset: int) -> void:
	if preset in RESOLUTION_VALUES:
		resolution_preset = preset
		_apply_resolution(preset)
		settings_changed.emit("resolution", RESOLUTION_VALUES[preset])
		save_settings()

func set_screen_mode(mode: int) -> void:
	if mode in SCREEN_MODE_VALUES:
		screen_mode = mode
		DisplayServer.window_set_mode(SCREEN_MODE_VALUES[mode])
		settings_changed.emit("screen_mode", mode)
		save_settings()

func set_fullscreen(enabled: bool) -> void:
	is_fullscreen = enabled
	settings_changed.emit("fullscreen", is_fullscreen)
	save_settings()

# ============= SAVE/LOAD =============
func save_settings() -> void:
	var config = ConfigFile.new()
	config.set_value("video", "vsync_mode", vsync_mode)
	config.set_value("video", "max_fps", max_fps)
	config.set_value("video", "resolution_preset", resolution_preset)
	config.set_value("video", "screen_mode", screen_mode)
	config.set_value("video", "is_fullscreen", is_fullscreen)
	config.save("user://settings.cfg")

func load_settings() -> void:
	var config = ConfigFile.new()
	if config.load("user://settings.cfg") == OK:
		vsync_mode = config.get_value("video", "vsync_mode", VSyncMode.MAILBOX)
		max_fps = config.get_value("video", "max_fps", 60)
		resolution_preset = config.get_value("video", "resolution_preset", ResolutionPreset.RES_1920_1080)
		screen_mode = config.get_value("video", "screen_mode", ScreenModePreset.EXCLUSIVE_FULLSCREEN)
		is_fullscreen = config.get_value("video", "is_fullscreen", true)
	else:
		# Set defaults if config doesn't exist
		vsync_mode = VSyncMode.MAILBOX
		max_fps = 60
		resolution_preset = ResolutionPreset.RES_1920_1080
		screen_mode = ScreenModePreset.EXCLUSIVE_FULLSCREEN
		is_fullscreen = true

# ============= RESET TO DEFAULTS =============
func reset_to_defaults() -> void:
	vsync_mode = VSyncMode.MAILBOX
	max_fps = 60
	resolution_preset = ResolutionPreset.RES_1920_1080
	screen_mode = ScreenModePreset.EXCLUSIVE_FULLSCREEN
	is_fullscreen = true
	apply_all_settings()
	save_settings()
