extends Node

@onready var v_sync_option_button: OptionButton = %VSyncOptionButton
@onready var max_fps_option_button: OptionButton = %MaxFpsOptionButton

const VSYNC_MODES = {
	0: DisplayServer.VSYNC_DISABLED,
	1: DisplayServer.VSYNC_ENABLED,
	2: DisplayServer.VSYNC_ADAPTIVE,
	3: DisplayServer.VSYNC_MAILBOX,
}

const MAX_FPS = {
	0: 0,   # unlimited
	1: 30,
	2: 60,
	3: 120,
	4: 144,
	5: 240,
}

func _ready() -> void:
	v_sync_option_button.clear()
	v_sync_option_button.add_item("Disabled", 0)
	v_sync_option_button.add_item("Enabled", 1)
	v_sync_option_button.add_item("Adaptive", 2)
	v_sync_option_button.add_item("Mailbox", 3)
	v_sync_option_button.select(3) # default Mailbox
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_MAILBOX)
	
	max_fps_option_button.clear()
	max_fps_option_button.add_item("Unlimited", 0)
	max_fps_option_button.add_item("30", 1)
	max_fps_option_button.add_item("60", 2)
	max_fps_option_button.add_item("120", 3)
	max_fps_option_button.add_item("144", 4)
	max_fps_option_button.add_item("240", 5)
	max_fps_option_button.select(2) # default 60
	Engine.max_fps = 60

func _on_v_sync_option_button_item_selected(index: int) -> void:
	DisplayServer.window_set_vsync_mode(VSYNC_MODES[index])

func _on_max_fps_option_button_item_selected(index: int) -> void:
	Engine.max_fps = MAX_FPS[index]
