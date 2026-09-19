extends Node2D

var round_is_termineted=false
var instance1=preload("res://scenes/enemy.tscn")
var instance2=preload("res://scenes/enemy2.tscn")
var enemy_killed=0
var round_number:int
@onready var player=$player
@onready var timer_for_monsters=$Timer
@export var spawn_points:Array[Vector2]

func end_round():
	var file=FileAccess.open("res://scripts/round_number.txt",FileAccess.WRITE)
	file.store_string(str(round_number+1))
	timer_for_monsters.stop()
	player.set_physics_process(false)
	print("You Won The "+str(round_number)+" round")
	#insert transition here

func spawn_a_monster():
	var get_random_position=randi_range(0,spawn_points.size()-1)
	var get_random_enemy=randi_range(1,2)
	
	if get_random_enemy==1:
		var enemy=instance1.instantiate()
		enemy.position=spawn_points[get_random_position]
		enemy.scale=Vector2(10,10)
		add_child(enemy)
	else:
		var enemy=instance2.instantiate()
		enemy.position=spawn_points[get_random_position]
		enemy.scale=Vector2(10,10)
		add_child(enemy)

func set_timer():
	var file=FileAccess.open("res://scripts/round_number.txt",FileAccess.READ)
	round_number=int(file.get_as_text())
	timer_for_monsters.wait_time=6/round_number
	timer_for_monsters.start()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_timer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if enemy_killed==(4*round_number) and not round_is_termineted:
		print("hi")
		round_is_termineted=true
		end_round()

func _on_timer_timeout() -> void:
	spawn_a_monster() # Replace with function body.
