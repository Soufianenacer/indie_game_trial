extends GlobalState

@onready var camera: Camera = $"../.."
@onready var utils: CameraUtils = $"../../utils"





func Phisics_Update(delta: float):
	if not camera.CAMERA_MODE.STATIC:
		Transitioned.emit(self, "camera_follow_player")
		camera.camera_mode = camera.CAMERA_MODE.FOLLOW_PLAYER
		return
		
	camera.global_position.lerp(
		camera.new_camera_target,
		utils._smooth_expo(camera.player_follow_speed, delta))








	
