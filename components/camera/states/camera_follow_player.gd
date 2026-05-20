extends GlobalState



@onready var camera: Camera = $"../.."
@onready var utils: CameraUtils = $"../../utils"



var mouse_look_ahead_current: Vector2 = Vector2.ZERO
var _screen_center: Vector2 = Vector2.ZERO


func Phisics_Update(delta: float):
	if not camera.CAMERA_MODE.FOLLOW_PLAYER:
		camera.camera_mode = camera.CAMERA_MODE.STATIC
		Transitioned.emit(self, "camera_scenes")
		return
	_follow_player(delta)





func _follow_player(delta: float) -> Vector2:
	if not camera.player:
		return camera.global_position
	
	var mouse_screen: Vector2 = get_viewport().get_mouse_position()
	var mouse_distance_to_center: Vector2 = mouse_screen - _screen_center
	
	var mouse_look_ahead_target = Vector2(
		clamp(
			mouse_distance_to_center.x / camera.mouse_look_ahead_sensitivity,
			-camera.mouse_look_ahead_max_distance_x,
			camera.mouse_look_ahead_max_distance_x
		),
		clamp(
			mouse_distance_to_center.y / camera.mouse_look_ahead_sensitivity,
			-camera.mouse_look_ahead_max_distance_y,
			camera.mouse_look_ahead_max_distance_y
		)
	)
	
	mouse_look_ahead_current = mouse_look_ahead_current.lerp(
		mouse_look_ahead_target,
		utils._smooth_expo(camera.mouse_look_ahead_speed, delta)
	)
	
	var camera_offset = Vector2(camera.camera_offset_x, camera.camera_offset_y)
	var camera_target = camera.player.global_position + mouse_look_ahead_current + camera_offset
	
	return camera.global_position.lerp(
		camera_target,
		utils._smooth_expo(camera.player_follow_speed, delta)
	)









	
