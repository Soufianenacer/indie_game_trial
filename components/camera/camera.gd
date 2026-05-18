extends Camera2D
class_name Camera

@onready var utils: CameraUtils = $utils

@export_category("Follow Player")
@export_range(1.0, 10.0, 0.1) var player_follow_speed: float = 3.0

@export_category("Mouse Look Ahead")
@export_range(1.0, 10.0, 0.1) var mouse_look_ahead_speed: float = 4.0
@export_range(1.0, 30.0, 0.1) var mouse_look_ahead_sensitivity: float = 15.0

@export_range(1.0, 100.0, 0.1) var mouse_look_ahead_max_distance: float = 20.0

@export_category("Camera")
@export_range(0.5, 2.5, 0.1) var initial_zoom: float = 1.0

var mouse_look_ahead_target: Vector2 = Vector2.ZERO
var mouse_look_ahead_current: Vector2 = Vector2.ZERO

var screen_center: Vector2 = Vector2.ZERO

var player: Player
var new_camera_target: Array[Vector2] = []

func _ready() -> void:
	add_to_group("camera")
	
	player = utils._get_first_in_group("player") as Player
	global_position = player.global_position
	
	zoom = Vector2(initial_zoom, initial_zoom)
	screen_center = get_viewport_rect().size / 2.0

func _set_new_camera_static_position(new_pos: Vector2):
	new_camera_target.push_front(new_pos)

func _set_camera_target_player():
	new_camera_target.clear()

func _physics_process(delta: float) -> void:
	# if there is a static camera position for animation play the animation
	if new_camera_target.size() > 0:
		global_position = global_position.lerp(new_camera_target[0],
		utils._smooth_expo(player_follow_speed, delta))
		return
	# else make the camera follow the player
	if not player:
		return
	
	var mouse_screen: Vector2 = get_viewport().get_mouse_position()
	var mouse_distance_to_center: Vector2 = mouse_screen - screen_center
	
	# setting max of look_ahead for both axes
	mouse_look_ahead_target = Vector2(
		clamp(
			mouse_distance_to_center.x / mouse_look_ahead_sensitivity,
			-mouse_look_ahead_max_distance,
			mouse_look_ahead_max_distance
			),
		clamp(
			mouse_distance_to_center.y / mouse_look_ahead_sensitivity,
			-mouse_look_ahead_max_distance,
			mouse_look_ahead_max_distance
			)
		)
	
	# smooth look ahead for both axes
	mouse_look_ahead_current = mouse_look_ahead_current.lerp(
		mouse_look_ahead_target,
		utils._smooth_expo(mouse_look_ahead_speed, delta)
	)
	
	# smooth follow player
	var camera_target: Vector2 = player.global_position + mouse_look_ahead_current
	
	global_position = global_position.lerp(camera_target,
		utils._smooth_expo(player_follow_speed, delta)
	)
