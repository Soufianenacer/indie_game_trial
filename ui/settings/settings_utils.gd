extends Node
class_name UtilsSettings

@onready var general: Control = %General

@onready var graohics_settings_ui: VBoxContainer = %Graphics_settings_ui
@onready var audio_ui: VBoxContainer = %AudioUi

@onready var inputs: Label = %inputs

enum SETTINGS_PAGES { GENERAL, GRAPHICS, AUDIO, INPUTS }


var setting_pages: Dictionary = {}

func _ready() -> void:
	setting_pages = {
	SETTINGS_PAGES.GENERAL: general,
	SETTINGS_PAGES.GRAPHICS: graohics_settings_ui,
	SETTINGS_PAGES.AUDIO: audio_ui,
	SETTINGS_PAGES.INPUTS: inputs,
}

func set_new_page(new_page: SETTINGS_PAGES):
	var current_page = setting_pages[new_page]
	current_page.visible = true
	for page_index in setting_pages:
		if page_index == new_page:
			continue
		var page = setting_pages[page_index]
		page.visible = false

func reset_pages():
	set_new_page(SETTINGS_PAGES.GENERAL)









	
