extends Area2D


@export var map_name: SceneManager.MAP_TYPES = SceneManager.MAP_TYPES.MAP_1

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var player: Player = body
		player.is_player_paused = true
		SceneManager.scene_transition_signal.emit(map_name, true)


func import_maps():
	for scene in SceneManager.stored_scenes:
		pass
	pass
