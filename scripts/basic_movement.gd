class_name Player
extends CharacterBody2D
var type_of_thing="PLAYER"
@export var attack_offset := 10.0
@export var damage=1
@export var velocity_coll:int
@onready var timer_for_roll=$Timer
@onready var player_collision_box=$CollisionShape2D
@onready var player_hurt_box=$Hurt_Box
@onready var health=$HUD/health
@onready var immortal_bar=$HUD/ImmortalBar
@onready var hit_box=$HitBox
@onready var timer_for_hitbox=$Timer2
@onready var sprite_of_hitbox=$HitBox/Sprite2D
@onready var animated_sprite = $AnimatedSprite2D

@onready var tomato_collector=$TomatoCollector
var is_attacking := false
var last_facing: StringName = &"front"
var roll_direction := Vector2.ZERO
var is_rolling=false
var contact_enemy=false
var bounce_velocity

func set_upgrades():
	var file=FileAccess.open("res://scripts/upgrades.txt", FileAccess.READ)
	var list_of_upgrades=file.get_csv_line()
	
	immortal_bar.timer_time+=int(list_of_upgrades[0]) #seconds
	velocity_coll+=int(list_of_upgrades[1])#in the 200
	damage+=int(list_of_upgrades[2])# int of 1
	
func position_the_hitbox() -> void:
	match last_facing:
		&"right":
			hit_box.position = Vector2(attack_offset, 0)
			hit_box.rotation = 0

		&"left":
			hit_box.position = Vector2(-attack_offset-60, 0)
			hit_box.rotation = PI

		&"front":
			hit_box.position = Vector2(-50, -30)
			hit_box.rotation = -PI / 2

		&"back":
			hit_box.position = Vector2(0, attack_offset)
			hit_box.rotation = PI / 2
			
	
func check_contact_with_enemy():
	if contact_enemy:
		var tween=create_tween()
		tween.tween_property(self,"position",bounce_velocity.normalized()*200+global_position,0.3)
		#velocity=bounce_velocity
		contact_enemy=false
	
func roll_like_crazy(x_direction,y_direction):
	player_hurt_box.monitoring=false
	velocity = roll_direction * velocity_coll * 3

func get_inputs():
	var x_direction=Input.get_axis("move_left","move_right")
	var y_direction=Input.get_axis("move_up","move_down")
	var direction = Vector2(x_direction, y_direction)

	
	if not is_rolling and not is_attacking:
		if direction != Vector2.ZERO:
			if abs(x_direction) > abs(y_direction):
				if x_direction < 0:
					last_facing = &"left"
				else:
					last_facing = &"right"
			else:
				if y_direction < 0:
					last_facing = &"front"
				else:
					last_facing = &"back"
					
			animated_sprite.play("run_" + String(last_facing))
		else:
			animated_sprite.play("idle_" + String(last_facing))
	else:
		animated_sprite.play()
	if Input.is_action_just_pressed("roll") and is_rolling==false:
		if direction != Vector2.ZERO:
			roll_direction = direction.normalized()
		else:
			roll_direction = get_facing_vector()
		
		timer_for_roll.start()
		is_rolling=true	
		animated_sprite.play("roll_" + String(last_facing))
	else:
		velocity=Vector2(x_direction,y_direction)*velocity_coll
	if is_rolling:
		roll_like_crazy(x_direction,y_direction)
	if Input.is_action_just_pressed("attack") and hit_box.monitoring!=true and not is_attacking and not is_rolling:
		
		is_attacking = true
		
		var attack_direction = get_facing_vector()
		position_the_hitbox()
		
		timer_for_hitbox.start()
		hit_box.monitoring=true
		sprite_of_hitbox.visible=true
		animated_sprite.play("attack_" + String(last_facing))
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_upgrades()
	animated_sprite.play("default")

func _2on_hit_box_body_entered(body: CharacterBody2D) -> void:
	print("Hit box touched: ", body.name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#print(position)
	get_inputs()
	check_contact_with_enemy()
	move_and_slide()


func _on_timer_timeout() -> void:
	is_rolling=false
	player_hurt_box.monitoring=true




func _on_hurt_box_body_entered(body: CharacterBody2D) -> void:
	#print( body.type_of_thing)
	if body.type_of_thing=="BAD" or body.type_of_thing=="ARROW":
		#print(body.name) # Replace with function body.
		if body.type_of_thing=="ARROW":
				body.queue_free()
		if immortal_bar.value<=0:
			health.take_damage(1)
			


func _on_hit_box_body_entered(body: CharacterBody2D) -> void:
	if body.type_of_thing=="BAD": 
		if body.health:
			body.health-=damage
			if body.name!="boss":
				body.knockback()
			else:
				body.is_hurt=true
			print(body.health)


func _on_timer_2_timeout() -> void:
	is_attacking = false
	hit_box.monitoring=false
	sprite_of_hitbox.visible=false# Replace with function body.
	
func get_facing_vector() -> Vector2:
	match last_facing:
		&"left":
			return Vector2.LEFT
		&"right":
			return Vector2.RIGHT
		&"front":
			return Vector2.UP
		&"back":
			return Vector2.DOWN

	return Vector2.DOWN
