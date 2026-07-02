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
	print(GameSettings.max_fps," ",GameSettings.vsync_mode)
	v_sync_option_button.select(GameSettings.vsync_mode)
	max_fps_option_button.select(GameSettings.max_fps)
	window_resolution_option_button.select(GameSettings.resolution_preset)
	full_screen_mode_option_button.select(GameSettings.screen_mode)
	
	window_resolution_option_button.disabled = GameSettings.screen_mode == 0
	
	#for i in range(v_sync_option_button.item_count):
		##if v_sync_option_button.get_item_id(i) == GameSettings.vsync_mode:
			#break
	
	# Find and select the fps option that matches current setting
	#print(max_fps_option_button.get_item_id(0), " - " , GameSettings.max_fps)
	#for i in range(max_fps_option_button.item_count):
		#if max_fps_option_button.get_item_id(i) == GameSettings.max_fps:
			#print(123)
			#break
	# Find and select the resolution that matches current setting
	#for i in range(window_resolution_option_button.item_count):
		#if window_resolution_option_button.get_item_id(i) == GameSettings.resolution_preset:
			#break
	
	# Find and select the screen mode that matches current setting
	#for i in range(full_screen_mode_option_button.item_count):
		#if full_screen_mode_option_button.get_item_id(i) == GameSettings.screen_mode:
			#break
	
