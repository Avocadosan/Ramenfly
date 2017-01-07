extends Node2D

var sfx

func _ready():
	sfx = get_node("/root/sfx")
	sfx._play_sensei()
	sfx._play_game_over()
	Input.set_mouse_mode(0)
	get_node("text/Label 2").set_text(str(get_node("/root/battleGlobal")._get_total_mosquitos_killed())+" Mosquitos to pay F")
	pass


func _on_TextureButton_pressed():
	get_tree().change_scene("res://temple/temple.tscn")
	queue_free()


func _on_credits_pressed():
	get_tree().change_scene("res://credits/credits.tscn")
	queue_free()
