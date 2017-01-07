extends Node2D

var sfx 

func _ready():
	sfx = get_node("/root/sfx")
	sfx._play_ramen_fly_intro()
	sfx._play_ramen_fly()
	OS.set_window_title("RamenFly")
	pass




func _on_Button_pressed():
	get_tree().change_scene("res://instructions/preInstructions.tscn")
	queue_free()


func _on_Button_mouse_enter():
	get_node("buttons/play/Sprite").set_frame(1)
	sfx._play_hit()
	


func _on_Button_mouse_exit():
	get_node("buttons/play/Sprite").set_frame(0)
	



func _on_Button1_mouse_enter():
	get_node("buttons/quit/Sprite").set_frame(3)
	sfx._play_ahh()


func _on_Button1_mouse_exit():
	get_node("buttons/quit/Sprite").set_frame(2)
	



func _on_Button1_pressed():
	get_tree().quit()


func _on_credits_pressed():
	get_tree().change_scene("res://credits/credits.tscn")
	queue_free()
