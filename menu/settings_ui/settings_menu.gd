extends PanelContainer

# Signal to notify the main menu when the player exits settings
signal back_pressed

@onready var volume_slider: HSlider = %VolumeSlider
@onready var resolution_options: OptionButton = %ResolutionOptions
@onready var fullscreen_check_box: CheckBox = %FullscreenCheckBox


# Scalable resolution list
const RESOLUTIONS: Array[Vector2i] = [
	Vector2i(640, 360),
	Vector2i(1280, 720),
	Vector2i(1600, 900),
	Vector2i(1920, 1080),
	Vector2i(2560, 1440),
	Vector2i(3840, 2160)
]

func _ready() -> void:
	_initialize_volume_slider()
	_initialize_resolution_dropdown()
	_initialize_fullscreen_checkbox()


# --- INITIALIZATION METHODS ---

func _initialize_volume_slider() -> void:
	#TODO : VOLUME INIT LOGIC
	pass


func _initialize_resolution_dropdown() -> void:
	resolution_options.clear()
	var current_window_size = DisplayServer.window_get_size()
	var current_match_index = 0 # Default
	
	for i in range(RESOLUTIONS.size()):
		var res = RESOLUTIONS[i]
		resolution_options.add_item(str(res.x) + " x " + str(res.y))
		if res == current_window_size:
			current_match_index = i
			
	resolution_options.selected = current_match_index
	print(current_match_index)


func _initialize_fullscreen_checkbox() -> void:
	var mode = DisplayServer.window_get_mode()
	var is_fullscreen = (mode == DisplayServer.WINDOW_MODE_FULLSCREEN or mode == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	fullscreen_check_box.button_pressed = is_fullscreen


# --- UI CONTROL SIGNALS ---

func _on_volume_slider_value_changed(_value: float) -> void:
	print(_value)
	AudioBus.set_bus_volume(_value, "SFX")
	pass # TODO : Audio logic


func _on_resolution_button_item_selected(index: int) -> void:
	var selected_res = RESOLUTIONS[index]
	DisplayServer.window_set_size(selected_res)
	
	# Center the window on the desktop after resizing
	var screen = DisplayServer.window_get_current_screen()
	var screen_size = DisplayServer.screen_get_size(screen)
	DisplayServer.window_set_position((Vector2(screen_size) / 2.0) - (Vector2(selected_res) / 2.0))



func _on_fullscreen_check_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_back_button_pressed() -> void:
	back_pressed.emit()
