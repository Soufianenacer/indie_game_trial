extends Control


@onready var utils: MenuUtils = %utils
@onready var settings_ui: Control = %SettingsUi

@onready var play: Button = $MainMeneContainer/Play
@onready var settings: Button = $MainMeneContainer/Settings
@onready var exit: Button = $MainMeneContainer/Exit




func _on_go_back_to_menu_btn_pressed() -> void:
	utils.menu_toggle_settings()
	settings_ui.settings_utils.reset_pages()


func _ready() -> void:
	play.connect("pressed", _on_play_pressed)
	settings.connect("pressed", _on_settings_pressed)
	exit.connect("pressed", _on_exit_pressed)

func _on_play_pressed():
	SceneManager.scene_transition_signal.emit("map_1")

func _on_settings_pressed():
	utils.menu_toggle_settings()

func _on_exit_pressed():
	get_tree().quit()
