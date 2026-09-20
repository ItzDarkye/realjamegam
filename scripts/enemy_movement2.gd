extends CharacterBody2D

var is_in_view=false
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player=$/root/Node2D/player
@export var tree_position:Vector2
var type_of_thing="BAD"
var health=7
var instance=preload("res://scenes/arrow.tscn")
@onready var timer_for_arrows=$Timer
var timer_is_stopped=true

var flash_material: ShaderMaterial
var flash_number := 0

func flash_white() -> void:
	flash_number += 1
	var this_flash := flash_number

	flash_material.set_shader_parameter("flash", true)
	await get_tree().create_timer(0.12).timeout

	if this_flash == flash_number:
		flash_material.set_shader_parameter("flash", false)

	
	

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
		if collider.get_collider() != null && collider.get_collider().name=="player":
			collider.get_collider().contact_enemy=true
			collider.get_collider().bounce_velocity=-(global_position-collider.get_collider().global_position).normalized()*5000
func shoot_player():
	await get_tree().create_timer(0.3).timeout
	#print("shooting arrow")
	velocity=velocity.normalized()
	var arrow=instance.instantiate()
	var vector_direction_player: Vector2=(-global_position+player.global_position)
	arrow.velocity=vector_direction_player.normalized()*100
	arrow.position=vector_direction_player.normalized()*10
	arrow.rotation=vector_direction_player.normalized().angle()
	if abs(arrow.velocity.x)>abs(arrow.velocity.y):
		
		if arrow.velocity.x<0:
			animated_sprite.play("attack_side")
			animated_sprite.flip_h=false
			await animated_sprite.animation_finished
		else:
			animated_sprite.flip_h=true
			animated_sprite.play("attack_side")
			await animated_sprite.animation_finished
	else:
		if arrow.velocity.y>0:
			
			animated_sprite.play("attack_front")
			await animated_sprite.animation_finished
		else:
			
			animated_sprite.play("attack_back")
			await animated_sprite.animation_finished
			
	add_child(arrow)

func follow_tree():
	var vector_direction_tree: Vector2=(-global_position+tree_position).normalized()
	velocity=vector_direction_tree*800
	if abs(velocity.x)>abs(velocity.y):
		
		if velocity.x<0:
			animated_sprite.play("walk_side")
			animated_sprite.flip_h=false
		else:
			animated_sprite.flip_h=true
			animated_sprite.play("walk_side")
	else:
		if velocity.y>0:
			
			animated_sprite.play("walk_front")
		else:
			
			animated_sprite.play("walk_back")

func giga_chad_enemy_movement():
	if is_in_view:
		var velocity=1800
		if is_in_view and timer_is_stopped:
		
			timer_for_arrows.start()
			timer_is_stopped=false
			shoot_player()
	else:
		if (-global_position+tree_position).length()>800:
			follow_tree()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	flash_material = animated_sprite.material.duplicate() as ShaderMaterial
	animated_sprite.material = flash_material
	flash_material.set_shader_parameter("flash", false)


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
