class_name Player
extends CharacterBody2D

@export var velocity_coll:int
@onready var timer_for_roll=$Timer
@onready var player_collision_box=$CollisionShape2D
@onready var tomato_collector=$TomatoCollector
var is_rolling=false



func roll_like_crazy(x_direction,y_direction):
	player_collision_box.disabled=true
	velocity=Vector2(x_direction,y_direction)*velocity_coll*3

func get_inputs():
	var x_direction=Input.get_axis("move_left","move_right")
	var y_direction=Input.get_axis("move_up","move_down")
	
	if Input.is_action_just_pressed("roll") and is_rolling==false:
		timer_for_roll.start()
		is_rolling=true
	else:
		velocity=Vector2(x_direction,y_direction)*velocity_coll
	if is_rolling:
		roll_like_crazy(x_direction,y_direction)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var max_health = $health.max_health
	print(max_health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	get_inputs()
	move_and_slide()


func _on_timer_timeout() -> void:
	is_rolling=false
	player_collision_box.disabled=false
