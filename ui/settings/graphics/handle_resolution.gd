extends Node
# This script goes on your settings menu/panel
# It connects all the UI buttons to the GameSettings singleton

# ============= NODE REFERENCES =============

@onready var window_resolution_option_button: OptionButton = %windowResolutionOptionButton
@onready var full_screen_mode_option_button: OptionButton = %FullScreenModeOptionButton
#@onready var full_screen_check_box: CheckBox = %FullScreenCheckBox

# ============= READY =============
func _ready() -> void:
	# Setup all the option buttons with their values
	_setup_resolution_options()
	_setup_screen_mode_options()
	
	# Connect signals so UI responds when settings change
	window_resolution_option_button.item_selected.connect(_on_resolution_changed)
	full_screen_mode_option_button.item_selected.connect(_on_screen_mode_changed)


func _setup_resolution_options() -> void:
	window_resolution_option_button.clear()
	# Loop through RESOLUTION_LABELS in GameSettings
	# This shows "1920 x 1080", "1280 x 720", etc.
	for preset in GameSettings.Graphics.RESOLUTION_LABELS:
		var label = GameSettings.Graphics.RESOLUTION_LABELS[preset]
		window_resolution_option_button.add_item(label, preset)

func _setup_screen_mode_options() -> void:
	full_screen_mode_option_button.clear()
	# Loop through SCREEN_MODE_LABELS in GameSettings
	# This shows "Fullscreen", "Borderless", "Windowed"
	for mode in GameSettings.Graphics.SCREEN_MODE_LABELS:
		var label = GameSettings.Graphics.SCREEN_MODE_LABELS[mode]
		full_screen_mode_option_button.add_item(label, mode)
	

func _on_resolution_changed(_index: int) -> void:
	var selected_preset = window_resolution_option_button.get_selected_id()
	
	GameSettings.set_resolution(selected_preset)

func _on_screen_mode_changed(_index: int) -> void:
	var selected_mode = full_screen_mode_option_button.get_selected_id()
	GameSettings.set_screen_mode(selected_mode)
	# Disable resolution option if not in windowed mode
	window_resolution_option_button.disabled = selected_mode == 0
