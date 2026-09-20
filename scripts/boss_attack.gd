extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer3.wait_time = 1.6
	$Timer3.one_shot = true
	$Timer3.start()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	monitoring=true # Replace with function body.
	

func _on_body_entered(body: CharacterBody2D) -> void:
	print(body)
	if body.name=="player":
		queue_free()
		if body.immortal_bar.time_left<=0:
			body.health.take_damage(2)
		if body.immortal_bar.time_left>=0:
			if body.immortal_bar.time_left-2>0:
				body.immortal_bar.time_left-=2
				body.immortal_bar.value=body.immortal_bar.time_left
			else:
				body.immortal_bar.time_left=0
				body.immortal_bar.value=body.immortal_bar.time_left


func _on_timer_2_timeout() -> void:
	queue_free() # Replace with function body.
	



func _on_timer_3_timeout() -> void:
	animated_sprite.play("fall")
