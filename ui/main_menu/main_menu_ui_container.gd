extends VBoxContainer
class_name MainMenuUI

@onready var utils: MenuUtils = %utils

@onready var play: Button = $Play
@onready var settings: Button = $Settings
@onready var exit: Button = $Exit

func _ready() -> void:
	play.connect("pressed", _on_play_pressed)
	settings.connect("pressed", _on_settings_pressed)
	exit.connect("pressed", _on_exit_pressed)

func _on_play_pressed():
	get_tree().change_scene_to_file("res://main.tscn")

func _on_settings_pressed():
	utils.menu_toggle_settings()

func _on_exit_pressed():
	get_tree().quit()





	
