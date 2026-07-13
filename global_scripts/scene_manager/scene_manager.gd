extends Node


@warning_ignore("unused_signal")
signal scene_transition_signal(name: String, animate: bool)

enum MAP_TYPES { MAP_1, MAP_2 }


const stored_scenes: Dictionary[MAP_TYPES, String] = {
	MAP_TYPES.MAP_1: "res://environment/maps/map_1.tscn" ,
	MAP_TYPES.MAP_2: "res://environment/maps/map_2.tscn" ,
}
