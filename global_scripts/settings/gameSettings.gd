# autoload/GameSettings.gd
extends Node

# =============================================
# ============= GENERAL SETTINGS =============
# =============================================

# general settings functions

# =============================================
# ============= GRAPHICS SETTINGS =============
# =============================================

@export var Graphics = preload("res://global_scripts/settings/local_utils/graphics.gd")

var FPS_VALUES = Graphics.FPS_VALUES
var RESOLUTION_VALUES = Graphics.RESOLUTION_VALUES
var SCREEN_MODE_VALUES = Graphics.SCREEN_MODE_VALUES
var VSyncMode = Graphics.VSyncMode
var MaxFPS = Graphics.MaxFPS
var ResolutionPreset = Graphics.ResolutionPreset
var ScreenModePreset = Graphics.ScreenModePreset
# ============= VIDEO SETTINGS =============
var vsync_mode: int = VSyncMode.MAILBOX
var max_fps: int = MaxFPS.FPS_60
var resolution_preset: int = ResolutionPreset.RES_1920_1080
var screen_mode: int = ScreenModePreset.WINDOWED

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
	if max_fps in FPS_VALUES:
		Engine.max_fps = FPS_VALUES[max_fps]

func apply_window_settings() -> void:
	DisplayServer.window_set_mode(SCREEN_MODE_VALUES[screen_mode])
	if RESOLUTION_VALUES.has(resolution_preset):
		_apply_resolution(resolution_preset)

func _apply_resolution(preset: int) -> void:
	var res = RESOLUTION_VALUES[preset]
	DisplayServer.window_set_size(res)
	var screen = DisplayServer.screen_get_size()
	DisplayServer.window_set_position((screen - res) / 2)

# ============= SETTERS (Called from UI) =============
func set_vsync(mode: int) -> void:
	vsync_mode = mode
	DisplayServer.window_set_vsync_mode(vsync_mode)
	save_settings()

func set_max_fps(preset: int) -> void:
	if preset in FPS_VALUES:
		max_fps = preset
		Engine.max_fps = FPS_VALUES[preset]
		save_settings()

func set_resolution(preset: int) -> void:
	if preset in RESOLUTION_VALUES:
		resolution_preset = preset
		_apply_resolution(preset)
		save_settings()

func set_screen_mode(mode: int) -> void:
	if mode in SCREEN_MODE_VALUES:
		screen_mode = mode
		DisplayServer.window_set_mode(SCREEN_MODE_VALUES[mode])
		save_settings()

# ============= SAVE/LOAD =============
func save_settings() -> void:
	var config = ConfigFile.new()
	config.set_value("video", "vsync_mode", vsync_mode)
	config.set_value("video", "max_fps", max_fps)
	config.set_value("video", "resolution_preset", resolution_preset)
	config.set_value("video", "screen_mode", screen_mode)
	config.save("user://settings.cfg")

func load_settings() -> void:
	var config = ConfigFile.new()
	if config.load("user://settings.cfg") == OK:
		vsync_mode = config.get_value("video", "vsync_mode", VSyncMode.MAILBOX)
		max_fps = config.get_value("video", "max_fps", MaxFPS.FPS_60)
		resolution_preset = config.get_value("video", "resolution_preset", ResolutionPreset.RES_1920_1080)
		screen_mode = config.get_value("video", "screen_mode", ScreenModePreset.EXCLUSIVE_FULLSCREEN)
	else:
		# Set defaults if config doesn't exist
		vsync_mode = VSyncMode.MAILBOX
		max_fps = MaxFPS.FPS_60
		resolution_preset = ResolutionPreset.RES_1920_1080
		screen_mode = ScreenModePreset.EXCLUSIVE_FULLSCREEN

# ============= RESET TO DEFAULTS =============
func reset_to_defaults() -> void:
	vsync_mode = VSyncMode.MAILBOX
	max_fps = MaxFPS.FPS_60
	resolution_preset = ResolutionPreset.RES_1920_1080
	screen_mode = ScreenModePreset.WINDOWED
	
	apply_all_settings()
	save_settings()
