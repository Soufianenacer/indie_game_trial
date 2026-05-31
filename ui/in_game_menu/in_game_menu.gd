extends CanvasLayer

@onready var settings_ui: Control = $Control/SettingsUi
@onready var in_game_menu_buttons: VBoxContainer = $Control/InGameMenuButtons

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		if settings_ui.visible:
			settings_ui.visible = false
			in_game_menu_buttons.visible = true
			return
		in_game_menu_buttons.visible = not in_game_menu_buttons.visible
		get_tree().paused = not get_tree().paused

func _on_go_back_pressed() -> void:
	settings_ui.visible = false
	in_game_menu_buttons.visible = true

func _on_keep_playing_pressed() -> void:
	in_game_menu_buttons.visible = false
	get_tree().paused = false

func _on_settings_pressed() -> void:
	settings_ui.visible = true
	in_game_menu_buttons.visible = false

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://ui/main_menu/menu_ui.tscn")

func _on_save_and_exit_pressed() -> void:
	get_tree().quit()
