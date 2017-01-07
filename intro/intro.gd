extends Node2D

onready var sfx = get_node("/root/sfx")

var picOne

func _ready():
	picOne = get_node("animations/picOne")
	pass


func _on_logo_finished():
	sfx._play_ramen_fly_intro()
	picOne.play("PicOne")
	get_tree().change_scene("res://main.tscn")
	queue_free()
