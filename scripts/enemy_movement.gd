class_name Enemy
extends CharacterBody2D

var is_in_view=false
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player=$/root/Node2D/player
@onready var tomato_collector=$TomatoCollector
@export var tree_position:Vector2
var type_of_thing="BAD"
var health=12
var side=false
var back=false
var front=false
var is_attacking=false

var flash_material: ShaderMaterial
var flash_number := 0

func flash_white() -> void:
	flash_number += 1
	var this_flash := flash_number

	flash_material.set_shader_parameter("flash", true)
	await get_tree().create_timer(0.12).timeout

	if this_flash == flash_number:
		flash_material.set_shader_parameter("flash", false)
	

	
	if this_flash == flash_number:
		animated_sprite.material.set_shader_parameter("flash", false)

func check_if_dead():
	if health<=0 or get_parent().round_is_termineted==true:
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
			
			if side:
				pass
				animated_sprite.play("attack_side_worm")
				
				
			if front:
				pass
				animated_sprite.play("attack_front_worm")
				
				
			if back:
				animated_sprite.play("attack_back_worm")
				
			is_attacking=true
			
			collider.get_collider().contact_enemy=true
			collider.get_collider().bounce_velocity=-(global_position-collider.get_collider().global_position).normalized()*5000
func follow_player():
	var vector_direction_player: Vector2=(-global_position+player.global_position)
	velocity=vector_direction_player.normalized()*800
	
	if abs(velocity.x)>abs(velocity.y):
		side=true
		front=false
		back=false
		if velocity.x<0:
			animated_sprite.play("worm_animation")
			animated_sprite.flip_h=false
		else:
			animated_sprite.flip_h=true
			animated_sprite.play("worm_animation")
	else:
		if velocity.y>0:
			front=true
			back=false
			side=false
			animated_sprite.play("front_walk_worm")
		else:
			back=true
			front=false
			side=false
			animated_sprite.play("back_walk_worm")

func follow_tree():
	var vector_direction_tree: Vector2=(-global_position+tree_position).normalized()
	velocity=vector_direction_tree*800
	if velocity.x>velocity.y:
		if velocity.x<0:
			animated_sprite.play("worm_animation")
			animated_sprite.flip_h=false
		else:
			animated_sprite.flip_h=true
			animated_sprite.play("worm_animation")
	else:
		if velocity.y>0:
			animated_sprite.play("front_walk_worm")
		else:
			animated_sprite.play("back_walk_worm")
func giga_chad_enemy_movement():
	if is_in_view:
		follow_player()
	else:
		follow_tree()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	flash_material = animated_sprite.material.duplicate() as ShaderMaterial
	animated_sprite.material = flash_material
	flash_material.set_shader_parameter("flash", false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	check_if_dead()
	if is_attacking==false:
		giga_chad_enemy_movement()
	
	check_collision_whit_player()
	#print(str(position))
	move_and_slide()


func _on_area_2d_body_entered(something) -> void:
	if something.name=="player":
		is_in_view=true


func _on_area_2d_body_exited(something) -> void:
	if something.name=="player":
		is_in_view=false


# Replace with function body.
