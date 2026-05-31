extends HBoxContainer

@export var resource_display_scene: PackedScene

var displays: Dictionary = {}


func _ready() -> void:
	ResourceManager.resource_changed.connect(_on_resource_changed)

	for resource_name in ResourceManager.resources:
		_create_display(
			resource_name,
			ResourceManager.resources[resource_name]
		)


func _on_resource_changed(resource_name: String,new_amount: int) -> void:

	if not displays.has(resource_name):
		_create_display(resource_name, new_amount)
		return

	displays[resource_name].set_data(resource_name,new_amount)


func _create_display(resource_name: String,amount: int) -> void:
	var display = resource_display_scene.instantiate()
	display.name = resource_name
	add_child(display)
	
	display.set_data(resource_name,amount)

	displays[resource_name] = display
