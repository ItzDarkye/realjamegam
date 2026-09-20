extends ProgressBar

func hurt_animation():
	self_modulate=Color(0.588, 0.001, 0.709, 1.0)
	await get_tree().create_timer(0.2).timeout
	self_modulate=Color(0.359, 0.071, 0.0, 0.729)
	await get_tree().create_timer(0.2).timeout
	self_modulate=Color(0.588, 0.001, 0.709, 1.0)
	await get_tree().create_timer(0.2).timeout
	self_modulate=Color(0.359, 0.071, 0.0, 0.729)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
