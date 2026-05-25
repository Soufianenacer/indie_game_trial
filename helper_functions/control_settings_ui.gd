extends CanvasLayer

@onready var max_fps_label: Label = $ui_helper/MarginContainer/VBoxContainer2/max_fps/Label
@onready var ui_helper: PanelContainer = $ui_helper

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("test_h"):
		ui_helper.visible = not ui_helper.visible

const v_sync_dic = {
	0: DisplayServer.VSYNC_ENABLED,
	1: DisplayServer.VSYNC_DISABLED,
	2: DisplayServer.VSYNC_ADAPTIVE,
	3: DisplayServer.VSYNC_MAILBOX,
}
const window_mode_dic = {
	0: DisplayServer.WINDOW_MODE_FULLSCREEN,
	1: DisplayServer.WINDOW_MODE_WINDOWED,
	2: DisplayServer.WINDOW_MODE_MINIMIZED,
	3: DisplayServer.WINDOW_MODE_MAXIMIZED,
	4: DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN
}

func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_MAILBOX)
	Engine.max_fps = 60
	get_tree().physics_interpolation = true

func _on_max_fpx_range_value_changed(value: int) -> void:
	max_fps_label.text = "Max FPS " + str(value)
	Engine.max_fps = value
	print(Engine.max_fps)

func _on_v_sync_btn_item_selected(index: int) -> void:
	DisplayServer.window_set_vsync_mode(v_sync_dic[index])

func _on_option_button_item_selected(index: int) -> void:
	DisplayServer.window_set_mode(window_mode_dic[index])

func _on_check_box_pressed() -> void:
	get_tree().physics_interpolation = not get_tree().physics_interpolation
