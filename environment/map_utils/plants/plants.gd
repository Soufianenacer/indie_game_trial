extends Area2D

@export var is_hitble: bool = true
@export var life_point: int = 5
@onready var map_1: Node2D = $".."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not is_hitble:
		return
	pass












	
