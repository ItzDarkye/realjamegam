extends CharacterBody2D
var type_of_thing="PLAYER"
@export var velocity_coll:int
@onready var timer_for_roll=$Timer
@onready var player_collision_box=$CollisionShape2D
@onready var player_hurt_box=$Hurt_Box
@onready var health=$HUD/health
@onready var immortal_bar=$HUD/ImmortalBar
@onready var hit_box=$HitBox
@onready var timer_for_hitbox=$Timer2
@onready var sprite_of_hitbox=$HitBox/Sprite2D

var is_rolling=false
var contact_enemy=false
var bounce_velocity

func position_the_hitbox(x_direction,y_direction):
	if x_direction==0 and y_direction==0:
		return
	if x_direction<0 and y_direction!=0:
		return
	if x_direction>0 and y_direction!=0:
		return
	hit_box.position=Vector2(x_direction,y_direction)*12
	hit_box.rotation=-Vector2(x_direction,y_direction).angle()
func check_contact_with_enemy():
	if contact_enemy:
		velocity=bounce_velocity
		contact_enemy=false
	
func roll_like_crazy(x_direction,y_direction):
	player_hurt_box.monitoring=false
	velocity=Vector2(x_direction,y_direction)*velocity_coll*3

func get_inputs():
	var x_direction=Input.get_axis("move_left","move_right")
	var y_direction=Input.get_axis("move_up","move_down")
	position_the_hitbox(x_direction,y_direction)
	if Input.is_action_just_pressed("roll") and is_rolling==false:
		timer_for_roll.start()
		is_rolling=true
	else:
		velocity=Vector2(x_direction,y_direction)*velocity_coll
	if is_rolling:
		roll_like_crazy(x_direction,y_direction)
	if Input.is_action_just_pressed("attack") and hit_box.monitoring!=true:
		timer_for_hitbox.start()
		hit_box.monitoring=true
		sprite_of_hitbox.visible=true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var max_health = $health.max_health
	print(max_health)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	get_inputs()
	check_contact_with_enemy()
	move_and_slide()


func _on_timer_timeout() -> void:
	is_rolling=false
	player_hurt_box.monitoring=true




func _on_hurt_box_body_entered(body: CharacterBody2D) -> void:
	#print( body.type_of_thing)
	if body.type_of_thing=="BAD" or body.type_of_thing=="ARROW":
		print(body.name) # Replace with function body.
		if body.type_of_thing=="ARROW":
				body.queue_free()
		if immortal_bar.value<=0:
			health.take_damage(1)
			


func _on_hit_box_body_entered(body: CharacterBody2D) -> void:
	if body.type_of_thing=="BAD": 
		if body.health:
			body.health-=1
			body.knockback()
			print(body.health)


func _on_timer_2_timeout() -> void:
	hit_box.monitoring=false
	sprite_of_hitbox.visible=false# Replace with function body.
