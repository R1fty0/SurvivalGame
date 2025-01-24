extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@export_category("Camera Settings")
@export var camera_sens: float = 29
# Limits in radians
@export var upper_look_limit: float = 1.5
@export var lower_look_limit: float = -1.5

var look_dir: Vector2
var lock_cursor: bool = false
@onready var camera: Camera3D = $Camera3D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	_lock_cursor()
	_rotate_camera(delta)
	move_and_slide()
	
	
func _input(event: InputEvent):
	if event is InputEventMouseMotion: 
		look_dir = event.relative * 0.01
		
func _lock_cursor():
	if Input.is_action_just_pressed("pause"):
		lock_cursor =!lock_cursor
		if lock_cursor:
			# Lock cursor
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			# Unlock cursor
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func _rotate_camera(delta: float, sens_mod: float = 1.0):
	var input: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	look_dir += input
	# Look around horizontally 
	rotation.y -= look_dir.x * camera_sens * delta
	# Look around vertically
	camera.rotation.x = clamp(camera.rotation.x - look_dir.y * camera_sens * sens_mod * delta,lower_look_limit, upper_look_limit)
	look_dir = Vector2.ZERO
