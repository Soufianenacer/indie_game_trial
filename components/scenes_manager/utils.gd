extends Node
class_name SceneManagerUtils

@onready var scene_paths: SceneManagerScenePaths = %scene_paths
@onready var scenes_container: Node = %scenes_container
@onready var transition_rect: ColorRect = %transition_rect

const FADE_IN_DURATION: float = 1.0
const FADE_OUT_DURATION: float = 0.5

func _load_scene(path: String, animate: bool = true) -> void:
	if animate: await _fade_in(1.0)
	
	_queue_free_all_scenes()
	var packed_scene: PackedScene = load(path)
	var new_scene = packed_scene.instantiate()
	scenes_container.add_child(new_scene)
	
	if animate: await _fade_out(0.0)
	else: transition_rect.modulate.a = 0.0

func _queue_free_all_scenes():
	for child in scenes_container.get_children():
		child.queue_free()

func _get_scene(new_scene_name: String) -> String:
	if new_scene_name == scene_paths.MAIN_MENU_SCENE:
		SceneManager.day_and_night_pause_signal.emit(true)
	else:
		SceneManager.day_and_night_pause_signal.emit(false)
	return scene_paths.stored_scenes[new_scene_name]

func _fade_in(target_alpha: float) -> void:
	var tween := create_tween()
	tween.tween_property(transition_rect, "modulate:a", target_alpha, FADE_IN_DURATION)
	await tween.finished
func _fade_out(target_alpha: float) -> void:
	var tween := create_tween()
	tween.tween_property(transition_rect, "modulate:a", target_alpha, FADE_OUT_DURATION)
	await tween.finished
