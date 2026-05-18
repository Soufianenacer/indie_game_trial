extends Node
class_name CameraUtils





func _get_first_in_group(group_name: String) -> Node:
	return get_tree().get_first_node_in_group(group_name)

func _get_group(group_name: String) -> Array[Node]:
	return get_tree().get_nodes_in_group(group_name)

func _smooth_expo(a: float,delta: float):
	return 1.0 - exp(-a * delta)





#
