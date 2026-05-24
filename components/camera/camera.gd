extends Camera2D
class_name Camera

@onready var utils: CameraUtils = $utils
@onready var camera_shake: CameraShake = $camera_shake


@onready var camera_follow_player: CameraFollowPlayer = $camera_follow_player
@onready var camera_scenes: CameraScenes = $camera_scenes

enum CAMERA_MODE { FOLLOW_PLAYER, STATIC }

@export_enum("Follow Player", "Static") var camera_mode: int = CAMERA_MODE.FOLLOW_PLAYER
@export_group("Zoom")
@export_range(0.5, 2.5, 0.1) var initial_zoom: float = 1.0
@export_range(1.0, 20.0, 0.1) var zoom_speed: float = 2.0

@export_group("Offset")
@export_range(-1000.0, 1000.0, 0.1) var camera_offset_x: float = 0.0
@export_range(-1000.0, 1000.0, 0.1) var camera_offset_y: float = 0.0

@export_group("Follow")
@export_range(1.0, 10.0, 0.1) var player_follow_speed: float = 3.0

@export_category("Look Ahead")
@export_group("Settings")
## Controls how fast the camera leads ahead of the mouse.
@export_range(1.0, 10.0, 0.1) var mouse_look_ahead_speed: float = 4.0
## Controls sensitivity X — lower values mean higher sensitivity.
@export_range(1.0, 30.0, 0.1) var mouse_look_ahead_sensitivity_x: float = 15.0
## Controls sensitivity Y — lower values mean higher sensitivity.
@export_range(1.0, 30.0, 0.1) var mouse_look_ahead_sensitivity_y: float = 15.0

@export_group("Limits")
## Maximum horizontal distance the camera can travel when following the mouse.
@export_range(1.0, 100.0, 0.1) var mouse_look_ahead_max_distance_x: float = 20.0
@export_range(1.0, 100.0, 0.1) var mouse_look_ahead_max_distance_y: float = 20.0


var screen_center: Vector2 = Vector2.ZERO
var player: Player
var new_camera_target: Vector2 = Vector2.ZERO
var current_zoom: Vector2 = Vector2(1.0, 1.0)

func _ready() -> void:
	add_to_group("camera")
	
	player = utils._get_first_in_group("player") as Player
	global_position = player.global_position
	
	current_zoom = Vector2(initial_zoom, initial_zoom)
	zoom = Vector2(initial_zoom, initial_zoom)
	
	screen_center = get_viewport_rect().size / 2.0

func _physics_process(delta: float) -> void:
	match camera_mode:
		CAMERA_MODE.FOLLOW_PLAYER:
			global_position = camera_follow_player._update(delta)
		CAMERA_MODE.STATIC:
			global_position = camera_scenes._update(delta)
	
	zoom = zoom.lerp(current_zoom, zoom_speed * delta)
	camera_shake._update(delta)

func _set_new_camera_static_position(new_pos: Vector2) -> void:
	new_camera_target = new_pos
	camera_mode = CAMERA_MODE.STATIC

func _new_zoom(new_zoom: Vector2) -> void:
	current_zoom = new_zoom

func _set_camera_shake() -> void:
	camera_shake.shake()

func _set_camera_target_player() -> void:
	camera_mode = CAMERA_MODE.FOLLOW_PLAYER













	
