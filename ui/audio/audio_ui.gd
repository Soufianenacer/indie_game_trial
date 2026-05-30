extends VBoxContainer

@onready var master_for_100: Label = $HBoxContainer/Master_for_100
@onready var sfx_for_100: Label = $HBoxContainer2/SFX_for_100
@onready var ambience_for_100: Label = $HBoxContainer3/Ambience_for_100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_mute_in_background_check_box_pressed() -> void:
	pass # Replace with function body.

func _on_master_volume_h_scroll_bar_value_changed(value: float) -> void:
	master_for_100.text = str(int(value), "%")
	pass # Replace with function body.

func _on_sfx_volume_h_scroll_bar_value_changed(value: float) -> void:
	sfx_for_100.text = str(int(value), "%")
	pass # Replace with function body.

func _on_ambience_volume_h_scroll_bar_value_changed(value: float) -> void:
	ambience_for_100.text = str(int(value), "%")
	pass # Replace with function body.
