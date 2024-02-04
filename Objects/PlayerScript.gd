extends CharacterBody2D


const SPEED = 300.0
var falldown_speed = 300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var move_time_after_sucess = 0.5
var move_time_left = 0

var possible_keys = ["0", "1", "2", "3", "A"]
var current_key : Key

func _ready():
	get_new_key()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_key_pressed(current_key):
		move_time_left += move_time_after_sucess
		get_new_key()
	
	if move_time_left > 0:
		velocity.x = Vector2.RIGHT.x * SPEED
		move_time_left -= delta
		# print_debug(move_time_left)
	elif position.y < 1150:
		velocity.x = Vector2.LEFT.x * falldown_speed
	else:
		velocity.x = 0

	move_and_slide()

func get_new_key():
	var new_index = randi_range(0, possible_keys.size()-1)
	current_key = OS.find_keycode_from_string(possible_keys[new_index])
	print_debug(possible_keys[new_index])
