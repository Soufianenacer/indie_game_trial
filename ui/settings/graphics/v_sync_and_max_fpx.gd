extends Node

@onready var v_sync_option_button: OptionButton = %VSyncOptionButton
@onready var max_fps_option_button: OptionButton = %MaxFpsOptionButton




func _ready() -> void:
	_setup_vsync_options()
	_setup_max_fps_options()
	
	
	v_sync_option_button.item_selected.connect(_on_vsync_changed)
	max_fps_option_button.item_selected.connect(_on_max_fps_changed)

func _setup_vsync_options() -> void:
	v_sync_option_button.clear()
	# Loop through the VSYNC_DIC dictionary in GameSettings
	for label: String in GameSettings.Graphics.VSYNC_DIC.keys():
		var vsync_enum_value = GameSettings.Graphics.VSYNC_DIC[label]
		v_sync_option_button.add_item(label, vsync_enum_value)

func _setup_max_fps_options() -> void:
	max_fps_option_button.clear()
	# Loop through the MAX_FPS_DIC dictionary in GameSettings
	for label: String in GameSettings.Graphics.MAX_FPS_DIC.keys():
		var fps_enum_value = GameSettings.Graphics.MAX_FPS_DIC[label]
		max_fps_option_button.add_item(label, fps_enum_value)

func _on_vsync_changed(_index: int) -> void:
	var selected_mode = v_sync_option_button.get_selected_id()
	GameSettings.set_vsync(selected_mode)

func _on_max_fps_changed(_index: int) -> void:
	var selected_fps = max_fps_option_button.get_selected_id()
	GameSettings.set_max_fps(selected_fps)



	
