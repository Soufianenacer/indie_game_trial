extends PanelContainer

@onready var label: Label = $Label

var resource_name: String

func set_data(resname: String, amount: int) -> void:
	resource_name = name
	label.text = "%s: %d" % [resname.capitalize(), amount]
