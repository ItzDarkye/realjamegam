extends CharacterBody2D

var is_in_view=false
@onready var player=$/root/Node2D/player
@export var tree_position:Vector2
var type_of_thing="BAD"
var health=4
var instance=preload("res://scenes/arrow.tscn")
@onready var timer_for_arrows=$Timer
var timer_is_stopped=true
func check_if_dead():
	if health==0 or get_parent().round_is_termineted==true:
		if health==0:
			get_parent().enemy_killed+=1
		queue_free()

func knockback():
	#print("Hi")
	var tween=create_tween()
	tween.tween_property(self,"position",velocity.normalized()*-200+global_position,0.3)
	#move_and_slide()

func check_collision_whit_player():
	var collider=get_last_slide_collision()
	if collider:
		if collider.get_collider().name=="player":
			
			collider.get_collider().contact_enemy=true
			collider.get_collider().bounce_velocity=-(global_position-collider.get_collider().global_position).normalized()*5000
func shoot_player():
	#await get_tree().create_timer(3).timeout
	#print("shooting arrow")
	velocity=velocity.normalized()
	var arrow=instance.instantiate()
	var vector_direction_player: Vector2=(-global_position+player.global_position)
	arrow.velocity=vector_direction_player.normalized()*100
	arrow.position=vector_direction_player.normalized()*10
	add_child(arrow)

func follow_tree():
	var vector_direction_tree: Vector2=(-global_position+tree_position).normalized()
	velocity=vector_direction_tree*200

func giga_chad_enemy_movement():
	if is_in_view:
		velocity=velocity.normalized()
		if is_in_view and timer_is_stopped:
		
			timer_for_arrows.start()
			timer_is_stopped=false
			shoot_player()
	else:
		follow_tree()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	check_if_dead()
	giga_chad_enemy_movement()
	check_collision_whit_player()
	move_and_slide()


func _on_area_2d_body_entered(something) -> void:
	if something.name=="player":
		is_in_view=true


func _on_area_2d_body_exited(something) -> void:
	if something.name=="player":
		is_in_view=false


func _on_timer_timeout() -> void:
	timer_is_stopped=true # Replace with function body.
