extends ProgressBar

signal time_to_notimm

@export var timer_time: float = 5
@export var tomato_time: float = 3.0

var time_left: float
var tomato_tween: Tween


@onready var tomato_collector := get_node("../../TomatoCollector") as TomatoCollector

func _ready() -> void:
	time_left = timer_time
	max_value = timer_time
	value = timer_time

	tomato_collector.tomato_collected.connect(add_tomato_time)

func _process(delta: float) -> void:
	if time_left <= 0.0:
		return

	time_left = maxf(time_left - delta, 0.0)
	if not tomato_tween or not tomato_tween.is_valid() or not tomato_tween.is_running():
		value = time_left

	if time_left <= 0.0:
		time_to_notimm.emit()
		set_process(false)

func add_tomato_time() -> void:
	time_left = minf(time_left + tomato_time, max_value)

	
	if tomato_tween and tomato_tween.is_valid():
		tomato_tween.kill()

	tomato_tween = create_tween()
	tomato_tween.tween_property(self, "value", time_left, 0.5)
	tomato_tween.set_trans(Tween.TRANS_SINE)
	tomato_tween.set_ease(Tween.EASE_OUT)

	set_process(true)
