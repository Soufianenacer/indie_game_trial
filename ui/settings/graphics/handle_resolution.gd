extends Node

@onready var full_screen_check_box: CheckBox = %FullScreenCheckBox
@onready var option_button: OptionButton = %OptionButton

const DEFAULT_RESOLUTION_INDEX = 2
const RESOLUTIONS = {
	0: Vector2i(1280, 720),
	1: Vector2i(1366, 768),
	2: Vector2i(1920, 1080),
	3: Vector2i(2560, 1440),
}
const FULLSCREEN_MODE : Dictionary = {
	true: DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN,
	false: DisplayServer.WINDOW_MODE_WINDOWED
}
var current_resolution_index: int = DEFAULT_RESOLUTION_INDEX

func _ready() -> void:
	option_button.clear()
	current_resolution_index = DEFAULT_RESOLUTION_INDEX
	for i in RESOLUTIONS:
		var res = RESOLUTIONS[i]
		option_button.add_item("%d x %d" % [res.x, res.y], i)
	
	var user_res = DisplayServer.screen_get_size()
	for i in RESOLUTIONS:
		if RESOLUTIONS[i] == user_res:
			current_resolution_index = i
			break
	
	option_button.select(current_resolution_index)
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	full_screen_check_box.button_pressed = true
	option_button.disabled = true

func _apply_resolution(index: int) -> void:
	var res = RESOLUTIONS[index]
	DisplayServer.window_set_size(res)
	await get_tree().process_frame
	var screen = DisplayServer.screen_get_size()
	DisplayServer.window_set_position((screen - res) / 2)
	current_resolution_index = index

func _on_full_screen_check_box_pressed() -> void:
	var is_fullscreen: bool = full_screen_check_box.button_pressed
	option_button.disabled = is_fullscreen
	DisplayServer.window_set_mode(FULLSCREEN_MODE[is_fullscreen])
	if not is_fullscreen:
		_apply_resolution(current_resolution_index)

func _on_option_button_item_selected(index: int) -> void:
	_apply_resolution(index)
