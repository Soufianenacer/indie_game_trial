extends Area2D

@export var is_hitble: bool = true
@export var life_point: int = 5


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not is_hitble:
		return
	pass
