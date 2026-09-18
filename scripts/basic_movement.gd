extends CharacterBody2D

func get_inputs():
	var x_direction=Input.get_axis("move_left","move_right")
	var y_direction=Input.get_axis("move_up","move_down")
	velocity=Vector2(x_direction,y_direction)*50
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	get_inputs()
	move_and_slide()
