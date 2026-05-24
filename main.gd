extends Node2D

@onready var fps: Label = $CanvasLayer/FPS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	fps.text = str(Engine.get_frames_per_second())
