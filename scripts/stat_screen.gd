extends Node2D

@export var button_gropu:ButtonGroup
@onready var strenght_label=$HUD2/Label
@onready var speed_label=$HUD2/Label2
@onready var health_label=$HUD2/Label3

func change_labels_text():
	var file1=FileAccess.open("res://scripts/upgrades.txt", FileAccess.READ)
	var array_of_stats=file1.get_csv_line()
	strenght_label.text=strenght_label.text+array_of_stats[2]
	speed_label.text=speed_label.text+str(int(array_of_stats[1])/200)
	health_label.text=health_label.text+str(int(array_of_stats[0])/5)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/ColorRect/AnimationPlayer2.play("fade_out")
	change_labels_text()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_next_button_pressed() -> void:
	print("hi")
	var upgrade_button=button_gropu.get_pressed_button()
	if upgrade_button:
		var file1=FileAccess.open("res://scripts/upgrades.txt", FileAccess.READ)
		var array_of_stats=file1.get_csv_line()
		var file=FileAccess.open("res://scripts/upgrades.txt", FileAccess.WRITE)
		var immortal_bar=array_of_stats[0]
		var speed=array_of_stats[1]
		var damage=array_of_stats[2]
		match upgrade_button.name:
			"Upgrade3":
				file.store_string(str(int(immortal_bar)+5)+","+speed+","+damage)
				get_tree().change_scene_to_file("res://scenes/main.tscn")
			"Upgrade2":
				file.store_string(immortal_bar+","+str(int(speed)+200)+","+damage)
				get_tree().change_scene_to_file("res://scenes/main.tscn")
			"Upgrade1":
				file.store_string(immortal_bar+","+speed+","+str(int(damage)+1))
				get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit() # Replace with function body.
