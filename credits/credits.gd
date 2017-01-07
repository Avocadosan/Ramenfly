extends Node2D



func _ready():
	OS.set_window_title("This is my first time doing a Ludum Dare :D")
	pass


func _on_Button_pressed():
	get_tree().change_scene("res://main.tscn")
	queue_free()
