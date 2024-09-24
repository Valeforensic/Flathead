extends Node3D

@onready var player_3d: CharacterBody3D = $"../Player 3d"
@onready var player_2d: CharacterBody3D = $"../Player 2d"

# Distance threshold for swap
@export var distance_threshold: float = 0.75  # The threshold at which we consider the characters to be swapped
var hold_duration = 0.0 # Timer to track the duration of the UI Down press
@export var hold_threshold: float = 0.5  # 0.5 seconds to swap back to player_3d
@export var swap_pushback: float = 0.3 # Amount of force applied to player_3d during swap, so when you swap back you're out of range

func _process(delta: float) -> void:
	# Check the distance between the two characters
	var distance = player_3d.global_transform.origin.distance_to(player_2d.global_transform.origin)
	
	if distance <= distance_threshold and player_3d.visible:
		swap_to_player_2d()

	# Handle "ui_down" hold to switch back to player_3d
	if Input.is_action_pressed("ui_down"):
		hold_duration += delta
		if hold_duration >= hold_threshold and player_2d.visible:
			swap_to_player_3d()
	else:
		# Reset hold duration if "ui_down" is released
		hold_duration = 0.0

func swap_to_player_3d() -> void:
	# Make player_3d visible and enable collisions
	player_3d.visible = true
	#player_3d.get_node("CollisionShape3D").disabled = false
	#Make player_2d invisible and disable collisions
	player_2d.visible = false
	#player_2d.get_node("CollisionShape3D").disabled = true

func swap_to_player_2d() -> void:
	# Make player_2d visible and enable collisions
	player_2d.visible = true
	 #(Add later?) player_2d.get_node("CollisionShape3D").disabled = false
	
	 # Make player_3d invisible and disable collisions
	player_3d.visible = false
	#player_3d.get_node("CollisionShape3D").disabled = true
	push_player_3d_back() # Push player_3d back by a small distance on the x-axis out of collision zone
	push_player_2d_foward()

func push_player_3d_back() -> void:
	# Calculate the current velocity and apply a push in the negative x-axis direction
	var velocity = Vector3(0, 0, swap_pushback)
	# Use move_and_slide() to push the player back
	player_3d.move_and_collide(velocity)

func push_player_2d_foward() -> void:
	# Calculate the current velocity and apply a push in the negative x-axis direction
	var velocity = Vector3(0, 0, -swap_pushback)
	# Use move_and_slide() to push the player back
	player_2d.move_and_collide(velocity)
