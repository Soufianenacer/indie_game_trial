
extends Area2D

@export var resource_name: String = "wood"
@export var clicks_required: int = 5
@export var resource_amount: int = 1

var current_clicks: int = 0

func _ready() -> void:
	input_pickable = true

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			_on_clicked()

func _on_clicked() -> void:
	current_clicks += 1

	if current_clicks >= clicks_required:
		ResourceManager.add_resource(resource_name, resource_amount)
		current_clicks = 0



















	
