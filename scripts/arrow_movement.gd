extends CharacterBody2D

var type_of_thing="ARROW"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var collider=move_and_collide(velocity)
	if collider:
		if collider.get_collider().name=="Wall":
			queue_free()
