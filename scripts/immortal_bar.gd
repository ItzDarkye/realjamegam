extends ProgressBar


signal time_to_notimm


@export var timer_time: float = 10.0

var time_left: float


func _ready() -> void:
	time_left = timer_time
	max_value = timer_time
	value = timer_time


func _process(delta: float) -> void:
	if time_left > 0:
		time_left -= delta
		value = time_left

		if time_left <= 0:
			time_left = 0
			value = 0
			time_to_notimm.emit()
			set_process(false)
