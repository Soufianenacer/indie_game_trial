extends Node



@onready var camera: Camera = get_parent() as Camera
@onready var utils: CameraUtils = $"../utils"


func _camera_static_position(delta: float) -> Vector2:
	return camera.global_position.lerp(
		camera.new_camera_target,
		utils._smooth_expo(camera.player_follow_speed, delta))
