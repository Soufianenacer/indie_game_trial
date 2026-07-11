extends Node2D

@onready var scenes_container: Node = $scenes_container
@onready var scene_paths: SceneManagerScenePaths = $scene_paths

@onready var utils: SceneManagerUtils = %utils

func _ready() -> void:
	var default_scene = utils._get_scene(scene_paths.MAIN_MENU_SCENE)
	utils._load_scene(default_scene, false)
	SceneManager.scene_transition_signal.connect(_on_scene_change_)

func _on_scene_change_(scene_name: String):
	utils._queue_free_all_scenes()
	var new_scene = utils._get_scene(scene_name)
	utils._load_scene(new_scene)


















	
