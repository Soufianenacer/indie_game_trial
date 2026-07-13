extends Node


@onready var transition_rect: ColorRect = $"../static/UI/transition_rect"


func _fade(target_alpha: float, fade_duration: float) -> void:
	var tween: Tween = create_tween()
	tween.tween_property(transition_rect, "modulate:a", target_alpha, fade_duration)
	await tween.finished
