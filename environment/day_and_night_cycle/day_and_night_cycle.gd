extends Node

@onready var canvas_modulate: CanvasModulate = %CanvasModulate
@onready var controller: DayAndNightController = %controller
@onready var sun_and_moon_lighting: Node = %sun_and_moon_lighting

func _ready() -> void:
	SceneManager.day_and_night_pause_signal.connect(_on_pause_cycle)
	_on_pause_cycle(true)

func _process(delta: float) -> void:
	canvas_modulate.color = controller.get_transition(
		canvas_modulate.color,
		controller.get_target_color(),
		delta
	)

func _on_pause_cycle(paused: bool) -> void:
	set_process(not paused)
	controller.set_process(not paused)
	sun_and_moon_lighting.set_process(not paused)
