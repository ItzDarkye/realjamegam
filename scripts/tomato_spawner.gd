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
	var base = box.global_position
	var dims : Vector2 = box.shape.size * box.global_scale
	#print("box.global_scale: ", box.global_scale)
	var offset = Vector2(randf_range(-dims.x, dims.x) / 2, randf_range(-dims.y, dims.y) / 2)
	newTomato.position = base + offset
	print("newTomato.position: ", newTomato.position)
	newTomato.max_scale = Vector2(randf_range(min_size, max_size), randf_range(min_size, max_size))
	add_child(newTomato)
