extends Node
class_name CameraShake

@onready var camera: Camera = get_parent() as Camera

@export var shake_enabled: bool = true
@export var is_infinite_shake: bool = false
@export_range(0.0, 60.0, 0.1) var shake_intensity: float = 5.0
@export_range(0.0, 2.0, 0.01) var shake_duration: float = 0.2
@export_range(1.0, 40.0, 0.1) var shake_frequency: float = 15.0

var _shake_timer: float = 0.0

func shake() -> void:
	if not shake_enabled:
		return
	_shake_timer = shake_duration

func stop_shake() -> void:
	_shake_timer = 0.0
	is_infinite_shake = false

func _update(delta: float) -> void:
	if not shake_enabled:
		return
	
	# skip if not shaking and not infinite
	if _shake_timer <= 0.0 and not is_infinite_shake:
		return
	
	var current_intensity: float
	
	if is_infinite_shake:
		# infinite shake always uses full intensity
		current_intensity = shake_intensity
	else:
		# normal shake fades out
		_shake_timer -= delta
		var progress = _shake_timer / shake_duration
		current_intensity = shake_intensity * progress
	
	camera.global_position += Vector2(
		sin(Time.get_ticks_msec() * shake_frequency) * current_intensity,
		cos(Time.get_ticks_msec() * shake_frequency) * current_intensity
	)
