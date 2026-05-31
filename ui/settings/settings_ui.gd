extends Control

@onready var settings_utils: UtilsSettings = $settings_utils

func _on_general_pressed() -> void:
	settings_utils.set_new_page(settings_utils.SETTINGS_PAGES.GENERAL)

func _on_graphics_pressed() -> void:
	settings_utils.set_new_page(settings_utils.SETTINGS_PAGES.GRAPHICS)

func _on_audio_pressed() -> void:
	settings_utils.set_new_page(settings_utils.SETTINGS_PAGES.AUDIO)

func _on_inputs_pressed() -> void:
	settings_utils.set_new_page(settings_utils.SETTINGS_PAGES.INPUTS)
