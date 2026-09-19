class_name Enemy
extends CharacterBody2D

var is_in_view=false
@onready var player=$/root/Node2D/player
@onready var tomato_collector=$TomatoCollector
@export var tree_position:Vector2

func check_collision_whit_player():
	var collider=get_last_slide_collision()
	if collider:
		if collider.get_collider().name=="player":
			
			collider.get_collider().contact_enemy=true
			collider.get_collider().bounce_velocity=-(global_position-collider.get_collider().global_position).normalized()*5000
func follow_player():
	var vector_direction_player: Vector2=(-global_position+player.global_position)
	velocity=vector_direction_player.normalized()*200

func follow_tree():
	var vector_direction_tree: Vector2=(-global_position+tree_position).normalized()
	velocity=vector_direction_tree*200

func giga_chad_enemy_movement():
	if is_in_view:
		follow_player()
	else:
		follow_tree()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	giga_chad_enemy_movement()
	#print(str(position))
	move_and_slide()


func _on_area_2d_body_entered(something) -> void:
	if something.name=="player":
		is_in_view=true


func _on_area_2d_body_exited(something) -> void:
	if something.name=="player":
		is_in_view=false
