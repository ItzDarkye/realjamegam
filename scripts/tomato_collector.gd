class_name TomatoCollector
extends Node2D


@export var body: CharacterBody2D

var collectedTomatoes = 0

signal tomato_collected


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(body)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func collect_a_tomato() -> void:
	collectedTomatoes += 1
	tomato_collected.emit()
	print(body, "Collected a Tomato!")
	print("Number of tomatoes: ", collectedTomatoes)

func offer_tomatoes_in_shrine() -> int:
	var offeredTomatoes = collectedTomatoes
	collectedTomatoes = 0
	print(body, "Offered ", offeredTomatoes, " tomatoes!")
	print("Number of tomatoes now: ", collectedTomatoes)
	return offeredTomatoes
