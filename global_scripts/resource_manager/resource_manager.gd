extends Node

var resources: Dictionary = {}

signal resource_changed(resource_name: String, new_amount: int)

func add_resource(resource_name: String, amount: int) -> void:
	if not resources.has(resource_name):
		resources[resource_name] = 0
		print_debug("new resource added" + resource_name)
	
	resources[resource_name] += amount
	resource_changed.emit(resource_name, resources[resource_name])

#if we have enough resource return true else false
func subtract_resource(resource_name: String, amount: int) -> bool: 
	if not resources.has(resource_name):
		return false

	if resources[resource_name] < amount:
		return false

	resources[resource_name] -= amount
	return true


func get_resource(resource_name: String) -> int:
	return resources.get(resource_name, 0)


func set_resource(resource_name: String, amount: int) -> void:
	resources[resource_name] = amount
	resource_changed.emit(resource_name, resources[resource_name])


func has_resource(resource_name: String, amount: int) -> bool:
	return get_resource(resource_name) >= amount


func reset_resource(resource_name: String) -> void:
	resources[resource_name] = 0
	resource_changed.emit(resource_name, resources[resource_name])


func reset_all() -> void:
	for resource_name in resources:
		resources[resource_name] = 0
		resource_changed.emit(resource_name, resources[resource_name])
	
