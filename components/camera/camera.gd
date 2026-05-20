extends Camera2D
class_name Camera

@onready var utils: CameraUtils = $utils

@onready var follow_player: CameraFollowPlayer = $follow_player
@onready var static_position: CameraScenes = $static_position

@export_category("Follow Player")
@export_group("Follow Player")
@export_range(1.0, 10.0, 0.1) var player_follow_speed: float = 3.0

@export_category("Mouse Look Ahead")
@export_group("Mouse Look Ahead")
@export_range(1.0, 10.0, 0.1) var mouse_look_ahead_speed: float = 4.0
@export_range(1.0, 30.0, 0.1) var mouse_look_ahead_sensitivity: float = 15.0

@export_group("Max distance")
@export_range(1.0, 100.0, 0.1) var mouse_look_ahead_max_distance_x: float = 20.0
@export_range(1.0, 100.0, 0.1) var mouse_look_ahead_max_distance_y: float = 0.0

@export_category("Camera")
@export_group("Camera")
@export_range(0.5, 2.5, 0.1) var initial_zoom: float = 1.0

@export_group("Camera offset")
@export_range(-300.0, 300.0, 0.1) var camera_offset_x: float = 0.0
@export_range(-300.0, 300.0, 0.1) var camera_offset_y: float = 0.0


var mouse_look_ahead_target: Vector2 = Vector2.ZERO
var mouse_look_ahead_current: Vector2 = Vector2.ZERO

var screen_center: Vector2 = Vector2.ZERO
var player: Player
var new_camera_target: Vector2 = Vector2.ZERO
# test of some function we can use
@export var camera_offset: Vector2 = Vector2.ZERO

enum CAMERA_MODE { FOLLOW_PLAYER, STATIC }
@export_enum("FOLLOW_PLAYER", "STATIC") var camera_mode: int = CAMERA_MODE.FOLLOW_PLAYER

func _ready() -> void:
	add_to_group("camera")
	
	player = utils._get_first_in_group("player") as Player
	global_position = player.global_position
	zoom = Vector2(initial_zoom, initial_zoom)
	screen_center = get_viewport_rect().size / 2.0


func _physics_process(delta: float) -> void:
	match camera_mode:
		CAMERA_MODE.FOLLOW_PLAYER: global_position = follow_player._follow_player(delta)
		CAMERA_MODE.STATIC: global_position = static_position._camera_static_position(delta)

func _set_new_camera_static_position(new_pos: Vector2):
	new_camera_target = new_pos
	camera_mode = CAMERA_MODE.STATIC

func _set_camera_target_player():
	camera_mode = CAMERA_MODE.FOLLOW_PLAYER













	
