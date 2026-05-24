extends Node
class_name CameraFollowPlayer

@onready var utils: CameraUtils = %utils
@onready var camera: Camera = get_parent() as Camera

var mouse_look_ahead_current: Vector2 = Vector2.ZERO

func _update(delta: float) -> Vector2:
	if not camera.player:
		return camera.global_position
	var mouse_screen: Vector2 = get_viewport().get_mouse_position()
	var mouse_distance_to_center: Vector2 = mouse_screen - camera.screen_center
	
	var mouse_look_ahead_target = Vector2(
		clamp(
			mouse_distance_to_center.x / camera.mouse_look_ahead_sensitivity_x,
			-camera.mouse_look_ahead_max_distance_x,
			camera.mouse_look_ahead_max_distance_x
		),
		clamp(
			mouse_distance_to_center.y / camera.mouse_look_ahead_sensitivity_y,
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
