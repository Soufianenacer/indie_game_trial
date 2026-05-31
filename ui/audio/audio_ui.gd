extends VBoxContainer

@onready var master_for_100: Label = $HBoxContainer/Master_for_100
@onready var sfx_for_100: Label = $HBoxContainer2/SFX_for_100
@onready var ambience_for_100: Label = $HBoxContainer3/Ambience_for_100

var master_bus: int = AudioServer.get_bus_index("Master")
var ambience_bus: int = AudioServer.get_bus_index("Ambience")
var sfx_bus: int = AudioServer.get_bus_index("SFX")

const VALUME_RED: float = 50.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_mute_in_background_check_box_pressed() -> void:
	#AudioServer.set_bus_mute(sfx_bus, true)
	pass # Replace with function body.

func _on_master_volume_h_scroll_bar_value_changed(value: float) -> void:
	master_for_100.text = str(int(value), "%")
	AudioServer.set_bus_volume_db(master_bus, value - VALUME_RED)

func _on_sfx_volume_h_scroll_bar_value_changed(value: float) -> void:
	sfx_for_100.text = str(int(value), "%")
	AudioServer.set_bus_volume_db(sfx_bus, value - VALUME_RED)

func _on_ambience_volume_h_scroll_bar_value_changed(value: float) -> void:
	ambience_for_100.text = str(int(value), "%")
	AudioServer.set_bus_volume_db(ambience_bus, value - VALUME_RED)
