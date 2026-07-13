extends Node
class_name DayAndNightCycle

@onready var canvas_modulate: CanvasModulate = %CanvasModulate
@onready var controller: DayAndNightController = %controller
@onready var sun_and_moon_lighting: SunAndMoonLighting = %sun_and_moon_lighting

const MIN_MULTIPLAYER: int = 60
@export_group("Cycle")
@export_range(0.1, 60.0, 1.0, "suffix:min")
var day_duration: float = 20.0
@export_range(0.1, 60.0, 1.0, "suffix:min")
var night_duration: float = 20.0


@export_group("Transition")
@export_range(0.1, 10.0, 0.1, "suffix:px/s")
var transition_speed: float = 1.0

@export_group("World Colors")
@export var day_color: Color = Color.WHITE
@export var night_color: Color = Color(0.18, 0.22, 0.40)

@export_group("Sun & Moon")
@export_range(0.0, 180.0, 1.0, "suffix:deg °")
var light_swing_angle: float = 60.0


func _ready() -> void:
	controller.day_duration = day_duration * MIN_MULTIPLAYER
	controller.night_duration = night_duration * MIN_MULTIPLAYER
	controller.transition_speed = transition_speed
	controller.day_color = day_color
	controller.night_color = night_color

	sun_and_moon_lighting.setup(light_swing_angle)


func _process(delta: float) -> void:
	# Single driving loop, explicit order: state first, then anything that reads it.
	controller.update(delta)

	canvas_modulate.color = controller.get_transition(
		canvas_modulate.color,
		controller.get_target_color(),
		delta
	)

	sun_and_moon_lighting.update(delta)
