extends Node2D

var round_is_termineted=false
@onready var player=$player
var instance1=preload("res://scenes/enemy.tscn")
var instance2=preload("res://scenes/enemy2.tscn")
var boss_instance=preload("res://scenes/boss.tscn")
var enemy_killed=0
var var_for_boss=0
var boss_defeated=false
@export var spawn_position_boss:Vector2
var round_number:int
@onready var timer_for_monsters=$Timer
@onready var shrine = $StaticBody2D/Shrine
@export var spawn_points:Array[Vector2]


func spawn_boss():
	var boss=boss_instance.instantiate()
	boss.position=spawn_position_boss
	boss.scale=Vector2(10,10)
	add_child(boss)
	
func end_round():
	var file=FileAccess.open("res://scripts/round_number.txt",FileAccess.WRITE)
	file.store_string(str(round_number+1))
	timer_for_monsters.stop()
	var player=$player
	player.set_physics_process(false)
	print("You Won The "+str(round_number)+" round")
	$CanvasLayer/fade_timer2.start()
	$CanvasLayer/ColorRect/AnimationPlayer.play("fade_in_player")
	
	

func spawn_player():
	var instance=preload("res://scenes/player.tscn")
	var player=instance.instantiate()
	var file=FileAccess.open("res://scripts/upgrades.txt", FileAccess.READ)
	var list_of_upgrades=file.get_csv_line()
	player.immortal_bar.max_value+=int(list_of_upgrades[0])
	player.velocity_coll+=int(list_of_upgrades[1])
	player.damage+=int(list_of_upgrades[1])
	add_child(player)
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
	if round_number<4:
		timer_for_monsters.wait_time=6/round_number
		timer_for_monsters.start()
func death():
	player.queue_free()
	var file=FileAccess.open("res://scripts/round_number.txt",FileAccess.WRITE)
	file.store_string("1")
	var files=FileAccess.open("res://scripts/upgrades.txt",FileAccess.WRITE)
	files.store_string("0,0,0")
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_timer()
	#spawn_player()
	$CanvasLayer/ColorRect/AnimationPlayer.play("fade_out")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not player.health.is_alive:
		death()
	if round_number<4:
		if enemy_killed==(4*round_number) and not round_is_termineted:
			print("hi")
			round_is_termineted=true
			end_round()
		elif shrine.offeredTomatoes >= 10 * round_number:
			print("offered ", shrine.offeredTomatoes, " tomatoes! So ending the round!")
			round_is_termineted=true
			end_round()
	else:
		if var_for_boss==0:
			var_for_boss+=1
			spawn_boss()
		if boss_defeated:
			print("Victory")
func _on_timer_timeout() -> void:
	spawn_a_monster() # Replace with function body.


func _on_fade_timer_2_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/stat_screen.tscn")
