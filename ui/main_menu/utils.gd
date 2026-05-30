extends Node
class_name MenuUtils

@onready var settings_ui: Control = %SettingsUi
@onready var main_menu_ui_container: VBoxContainer = %MainMenuUiContainer



func menu_toggle_settings():
	settings_ui.visible = not settings_ui.visible
	main_menu_ui_container.visible = not main_menu_ui_container.visible







	
