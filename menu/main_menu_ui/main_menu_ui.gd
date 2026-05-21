extends VBoxContainer

signal start_button_pressed
signal settings_button_pressed
signal quit_button_pressed


func _ready() -> void:
	pass

func _on_start_button_pressed() -> void:
	start_button_pressed.emit()

func _on_settings_button_pressed() -> void:
	settings_button_pressed.emit()

func _on_quit_button_pressed() -> void:
	quit_button_pressed.emit()
