extends Node2D

@onready var scenes_container: Node = $scenes_container
@onready var utils: SceneManagerUtils = $utils


func _ready() -> void:
	SceneManager.scene_transition_signal.connect(_on_scene_change_)
	_on_scene_change_(SceneManager.MAP_TYPES.MAP_1, true)


func _on_scene_change_(scene_name: SceneManager.MAP_TYPES, animate: bool):
	utils._load_scene(scene_name, animate)


















	
