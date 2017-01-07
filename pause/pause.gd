extends Node2D

var boolPause = false
var animation 

func _ready():
	animation = get_node("AnimationPlayer")
	set_process_input(true)
	
func _input(event):
	if event.is_action_pressed("enter") and !boolPause:
		get_tree().set_pause(true)
		animation.play("appear")
		boolPause = true
	elif  event.is_action_pressed("enter") and boolPause:
		get_tree().set_pause(false)
		animation.play_backwards("appear")
		boolPause = false
		
