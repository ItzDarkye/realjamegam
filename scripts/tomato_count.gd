extends Label

@onready var tomato_collector := get_node("../../TomatoCollector") as TomatoCollector

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tomato_collector.tomato_collected.connect(updateCount)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func updateCount() -> void:
	self.text = str(tomato_collector.collectedTomatoes)
