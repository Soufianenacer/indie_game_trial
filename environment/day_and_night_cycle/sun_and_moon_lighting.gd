extends Node

@onready var light: DirectionalLight2D = %moon_and_sun_directional_light
@onready var controller: DayAndNightController = %controller

const DEFAULT_ANGLE: int = 60
const START_ANGLE: float = deg_to_rad(-DEFAULT_ANGLE)
const END_ANGLE: float = deg_to_rad(DEFAULT_ANGLE)

func _ready() -> void:
	light.rotation = START_ANGLE

func _process(delta: float) -> void:
	if light.rotation < END_ANGLE:
		light.rotation += (END_ANGLE - START_ANGLE) / controller.get_phase_duration() * delta
	else:
		light.rotation = START_ANGLE
