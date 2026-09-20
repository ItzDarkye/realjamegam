extends Node2D

var offeredTomatoes = 0
@onready var area = $Area2D
@onready var tomatoCount = $OfferedTomatoCount

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area.body_entered.connect(_on_body_entered)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body : Node2D) -> void:
	if body is Player:
		var receivedTomatoes = body.tomato_collector.offer_tomatoes_in_shrine()
		offeredTomatoes += receivedTomatoes
		tomatoCount.text = str(offeredTomatoes)
		print("Shrine: received ", receivedTomatoes, " tomatoes")
		print("Shrine: total tomatoes: ", offeredTomatoes)
