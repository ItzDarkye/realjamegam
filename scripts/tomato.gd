class_name Tomato
extends Node2D


@onready var area = $Area2D
@export var max_scale: Vector2 = Vector2(0.2, 0.2)
@export var lifeDuration = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grow()
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = lifeDuration
	timer.one_shot = true
	timer.start()
	# tomato vanishes after getting decayed.
	timer.timeout.connect(shrink_and_destroy)
	area.body_entered.connect(_on_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func grow() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", max_scale, 0.5).from(Vector2.ZERO)

func shrink_and_destroy() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ZERO, 0.5)
	tween.finished.connect(queue_free)

func _on_body_entered(body : Node2D) -> void:
	#print("something entered this tomato!")
	if body.get_parent() is Tomato:
		return
	if body is Player or body is Enemy:
		#print("body is Player or body is Enemy")
		
		body.tomato_collector.collect_a_tomato()
		shrink_and_destroy()
