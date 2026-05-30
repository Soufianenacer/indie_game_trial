extends Node
@onready var fxaa_check_box: CheckBox = $"../HBoxContainer8/FXAACheckBox"

func _ready() -> void:
	get_viewport().screen_space_aa = Viewport.SCREEN_SPACE_AA_FXAA
	fxaa_check_box.button_pressed = true

func _on_msaa_check_box_pressed() -> void:
	if fxaa_check_box.button_pressed:
		get_viewport().screen_space_aa = Viewport.SCREEN_SPACE_AA_FXAA
	else:
		get_viewport().screen_space_aa = Viewport.SCREEN_SPACE_AA_DISABLED


func _on_rest_button_pressed() -> void:
	print("Reset")
	pass # Replace with function body.
