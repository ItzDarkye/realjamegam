extends CharacterBody2D

@onready var player=$/root/Node2D/player
@onready var tomato_collector=$TomatoCollector
var instance=preload("res://scenes/boss_attack.tscn")
@onready var healt_bar=$ProgressBar
var type_of_thing="BAD"
var health=14
var is_hurt=false

func check_if_dead():
	if health<=0 or get_parent().round_is_termineted==true:
		if health==0:
			get_parent().boss_defeated=true
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



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	healt_bar.max_value=14
	healt_bar.value=health 
func _process(delta: float) -> void:
	healt_bar.value=health
func hit_player():
	var attack=instance.instantiate()
	attack.global_position=player.global_position
	attack.scale=Vector2(10,10)
	add_sibling(attack)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	check_if_dead()
	if is_hurt:
		healt_bar.hurt_animation()
		is_hurt=false
	move_and_slide()
	


func _on_timer_timeout() -> void:
	
	hit_player() # Replace with function body.
