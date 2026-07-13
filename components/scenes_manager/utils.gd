extends Node
class_name SceneManagerUtils

#@onready var scene_paths: SceneManagerScenePaths = $"../scene_paths"
@onready var fade_animation: Node = $"../fade_animation"
@onready var scenes_container: Node = $"../scenes_container"


const FADE_IN_DURATION: float = 0.5
const FADE_OUT_DURATION: float = 0.5

func _load_scene(scene_name: SceneManager.MAP_TYPES, animate: bool = true) -> void:
	if animate:
		await fade_animation._fade(1.0, FADE_IN_DURATION)
	
	_queue_free_all_scenes()
	await _wait_until_container_is_empty()
	
	var scene_path = _get_scene(scene_name)
	var packed_scene: PackedScene = load(scene_path)
	
	if not packed_scene:
		push_error("SceneManagerUtils: Could not load scene at path: " + str(scene_path))
		return
	
	var new_scene = packed_scene.instantiate()
	scenes_container.add_child(new_scene)
	
	if animate:
		await fade_animation._fade(0.0, FADE_OUT_DURATION)


## Loops and yields frames dynamically until Godot confirms the nodes are completely removed from memory.
func _wait_until_container_is_empty() -> void:
	# Keep checking every single engine tick
	while scenes_container.get_child_count() > 0:
		await get_tree().process_frame
	# A tiny extra fallback safety step to let the garbage collector breathe
	await get_tree().process_frame


func _queue_free_all_scenes() -> void:
	for child in scenes_container.get_children():
		if is_instance_valid(child):
			child.queue_free()

func _get_scene(new_scene_name: SceneManager.MAP_TYPES) -> String:
	return SceneManager.stored_scenes[new_scene_name]
