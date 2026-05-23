extends CharacterBody2D
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var direction: float = 0.0

func _ready() -> void:
	add_to_group("player")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Press E to set a new camera location
	if Input.is_action_just_pressed("test_e"):
		var camera: Camera = _get_first_in_group("camera") as Camera
		camera._set_new_camera_static_position(Vector2(2.0, 100.0))
		camera._new_zoom(Vector2(2.0,2.0))
		AudioBus._play_sound_at(self, "the_forest_sounds", 5.0, 0.5)
	# Press A/Q to folow the player
	if Input.is_action_just_pressed("test_a"):
		var camera: Camera = _get_first_in_group("camera") as Camera
		camera._set_camera_shake()
		camera._set_camera_target_player()
		camera._new_zoom(Vector2(1.0,1.0))
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("move_left", "move_right")
	if direction: velocity.x = direction * SPEED
	else: velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()













func _get_first_in_group(group_name: String) -> Node:
	return get_tree().get_first_node_in_group(group_name)
