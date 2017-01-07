extends Node2D

var sfx 

func _ready():
	sfx = get_node("/root/sfx")
	sfx._play_ramen_fly_intro()
	sfx._play_grunt()
	pass


func _on_Button_pressed():
	get_tree().change_scene("res://instructions/instructions.tscn")
	queue_free()
