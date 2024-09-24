extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 6.5
const WALL_SETTING = 0.5


@onready var player_3d: CharacterBody3D = $"../Player 3d"





func _process(delta: float) -> void: #tracking while voided
	if player_3d.visible == true:
		global_position.x = player_3d.global_position.x
		global_position.y = player_3d.global_position.y
		
		
	if player_3d.visible == false:
			velocity.z = -WALL_SETTING

			# Add the gravity.
			if not is_on_floor():
				velocity += get_gravity() * delta

			# Handle jump.
			if Input.is_action_just_pressed("ui_accept") and is_on_floor():
				velocity.y = JUMP_VELOCITY

			# Get the input direction and handle the movement/deceleration.
			# As good practice, you should replace UI actions with custom gameplay actions.
			var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
			var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
			if direction:
				velocity.x = direction.x * SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
				velocity.z = move_toward(velocity.z, 0, SPEED)
				
			
		

			move_and_slide()
