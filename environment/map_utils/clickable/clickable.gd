
extends Area2D

@export var resource_name: String = "wood"
@export var clicks_required: int = 5
@export var resource_amount: int = 1

@export var sound_effect_name: String = ""

var current_clicks: int = 0
var player: Player

func _ready() -> void:
	input_pickable = true
	player = get_tree().get_first_node_in_group("player") as Player

 
func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if not player: return
	if player.global_position.distance_to(global_position) > player.harvest_range:
		return
	
	if event.is_action_pressed("left_click"):
		_on_clicked()
		print(123)

func _on_clicked() -> void:
	AudioBus._play_sound(sound_effect_name, true ,self)
	current_clicks += 1
	if current_clicks >= clicks_required:
		ResourceManager.add_resource(resource_name, resource_amount)
		current_clicks = 0















	
