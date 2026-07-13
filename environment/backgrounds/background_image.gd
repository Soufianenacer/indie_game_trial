extends Node2D

@export var follow_factor: float = 0.95
@export var camera_speed: float = 100.0

@onready var camera: Camera2D = get_tree().get_first_node_in_group("camera") as Camera2D

var initial_camera_pos: Vector2
var initial_bg_pos: Vector2

func _ready():
	initial_camera_pos = camera.global_position
	initial_bg_pos = camera.global_position
	global_position = camera.global_position

func _process(delta):
	var camera_offset = camera.global_position - initial_camera_pos
	global_position = global_position.lerp(
		initial_bg_pos + camera_offset * follow_factor,
		camera_speed * delta)
