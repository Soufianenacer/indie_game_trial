extends Control


@onready var utils: MenuUtils = %utils
@onready var settings_ui: Control = %SettingsUi




func _on_go_back_to_menu_btn_pressed() -> void:
	utils.menu_toggle_settings()
	settings_ui.settings_utils.reset_pages()
