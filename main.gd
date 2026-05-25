extends Node2D

@onready var fps: Label = $CanvasLayer/FPS


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	fps.text = str(Engine.get_frames_per_second())
