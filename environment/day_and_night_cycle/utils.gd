extends Node
class_name DayAndNightController

@export_group("Cycle")
@export_range(1.0, 3600.0, 1.0, "suffix:s")
var day_duration: float = 5.0
@export_range(1.0, 3600.0, 1.0, "suffix:s")
var night_duration: float = 20.0

@export_group("Transition")
@export_range(0.1, 10.0, 0.1)
var transition_speed: float = 1.0

@export_group("World Colors")
@export var day_color: Color = Color.WHITE
@export var night_color: Color = Color(0.18, 0.22, 0.40)

var is_day: bool = true
var _elapsed: float = 0.0

func _process(delta: float) -> void:
	_elapsed += delta

	var duration := get_phase_duration()
	if _elapsed >= duration:
		_elapsed -= duration # keep the overflow instead of resetting to 0
		_on_day_night_switch()

func _on_day_night_switch() -> void:
	is_day = not is_day

	if not is_day:
		AudioBus._play_sound("night_omg_effect", false)

# Public API — called from sibling scripts (sun/moon lighting, orchestrator)
func get_phase_duration() -> float:
	return day_duration if is_day else night_duration

func get_transition(current: Color, target: Color, delta: float) -> Color:
	return current.lerp(target, transition_speed * delta)

func get_target_color() -> Color:
	return day_color if is_day else night_color
