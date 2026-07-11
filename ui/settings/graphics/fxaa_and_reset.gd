extends Node

@onready var full_screen_mode_option_button: OptionButton = %FullScreenModeOptionButton
@onready var window_resolution_option_button: OptionButton = %windowResolutionOptionButton
@onready var v_sync_option_button: OptionButton = %VSyncOptionButton
@onready var max_fps_option_button: OptionButton = %MaxFpsOptionButton

@onready var rest_button: Button = %RestButton


func _ready() -> void:
	_update_ui_from_settings()
	rest_button.connect("pressed",_on_rest_button_pressed)

func _on_rest_button_pressed() -> void:
	GameSettings.reset_to_defaults()
	_update_ui_from_settings()


func _update_ui_from_settings():
	v_sync_option_button.select(GameSettings.vsync_mode)
	max_fps_option_button.select(GameSettings.max_fps)
	window_resolution_option_button.select(GameSettings.resolution_preset)
	full_screen_mode_option_button.select(GameSettings.screen_mode)
	
	window_resolution_option_button.disabled = GameSettings.screen_mode == 0
