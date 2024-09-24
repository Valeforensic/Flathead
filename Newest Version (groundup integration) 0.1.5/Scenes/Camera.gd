extends Camera3D

@onready var player_3d: CharacterBody3D = $"../Player 3d"
@onready var player_2d: CharacterBody3D = $"../Player 2d"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if player_3d.visible == true:
		global_position.x = player_3d.global_position.x 
		global_position.y = player_3d.global_position.y + 3
	
	if player_2d.visible == true:
		global_position.x = player_2d.global_position.x 
		global_position.y = player_2d.global_position.y + 3
