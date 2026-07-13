extends Node
class_name SunAndMoonLighting

@onready var light: DirectionalLight2D = %moon_and_sun_directional_light
@onready var controller: DayAndNightController = %controller

var _start_angle: float
var _end_angle: float


func setup(swing_angle_degrees: float) -> void:
	_start_angle = deg_to_rad(-swing_angle_degrees)
	_end_angle = deg_to_rad(swing_angle_degrees)
	light.rotation = _start_angle


func update(delta: float) -> void:
	if light.rotation < _end_angle:
		light.rotation += (_end_angle - _start_angle) / controller.get_phase_duration() * delta
	else:
		light.rotation = _start_angle
