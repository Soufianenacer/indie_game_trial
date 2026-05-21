extends Control
@onready var main_menu_ui: VBoxContainer = %MainMenuUI
@onready var settings_menu_ui: PanelContainer = %SettingsMenuUI

func _ready() -> void:
	main_menu_ui.show()
	settings_menu_ui.hide()

# --- INCOMING SIGNALS FROM MAIN MENU BUTTONS ---

func _on_main_menu_ui_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")

func _on_settings_button_pressed() -> void:
	main_menu_ui.hide()
	settings_menu_ui.show()

func _on_main_menu_ui_quit_button_pressed() -> void:
	get_tree().quit()

# --- INCOMING SIGNALS FROM SETTINGS ---

func _on_settings_back_pressed() -> void:
	settings_menu_ui.hide()
	main_menu_ui.show()
