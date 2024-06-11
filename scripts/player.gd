extends CharacterBody3D

@onready var animation_player = $Node3D/mixamo_base/AnimationPlayer

const SPEED = 3.0
const JUMP_VELOCITY = 4.5

var walking_speed = 3.0
var running_speed = 4.0

#func _ready() -> void:
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("right", "left", "down", "up")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		#animation_player.play("walking")
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		#animation_player.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _on_area_3d_body_entered(body: Node3D) -> void:
	animation_player.play("knock_down")
	print("should play knock_down animation")

#todo make animation lock


func _on_spooky_body_entered(body: Node3D) -> void:
	get_tree().change_scene_to_file("res://scenes/jumpscare.tscn")