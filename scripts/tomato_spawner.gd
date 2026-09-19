extends Node2D

@onready var timer = $Timer
@export var tomato = preload("res://scenes/tomato.tscn")
@export var min_size = 0.007
@export var max_size = 0.010
@export var box: CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(spawnTomato)
	#print("box details")
	#var dims : Vector2 = box.shape.size
	#print(dims)
	#print(box.transform)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawnTomato():
	#print("Spawning tomato!")
	var newTomato = tomato.instantiate()
	var dims : Vector2 = box.shape.size
	newTomato.position = Vector2(randf_range(0.0, dims.x), randf_range(0.0, dims.y))
	#print("newTomato.position: ", newTomato.position)
	newTomato.max_scale = Vector2(randf_range(min_size, max_size), randf_range(min_size, max_size))
	add_child(newTomato)
	
