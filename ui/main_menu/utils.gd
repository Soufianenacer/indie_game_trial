extends Node
class_name MenuUtils

@onready var settings_ui: Control = %SettingsUi
@onready var main_mene_container: VBoxContainer = %MainMeneContainer



func menu_toggle_settings():
	settings_ui.visible = not settings_ui.visible
	main_mene_container.visible = not main_mene_container.visible







	
