extends Node2D

var button_type = null



func _on_start_pressed() -> void:
	button_type = "start"
	$Fade_Transition.show()
	$Fade_Transition/fade_timer.start()
	$Fade_Transition/AnimationPlayer.play("fade_in")


func _on_options_pressed() -> void:
		button_type = "options"
		$Fade_Transition.show()
		$Fade_Transition/fade_timer.start()
		$Fade_Transition/AnimationPlayer.play("fade_in")
		

func _on_exit_pressed() -> void:
	button_type = "exit"
	$Fade_Transition.show()
	$Fade_Transition/fade_timer.start()
	$Fade_Transition/AnimationPlayer.play("fade_in")
	


func _on_fade_timer_timeout():
	if button_type == "start":
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	elif button_type == "exit":
		get_tree().quit()
	elif button_type == "options":
		get_tree().change_scene_to_file("res://scenes/options.tscn")
