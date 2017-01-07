extends KinematicBody2D

#velocity of our player
export (int) var velocity 

#Bool for input
var keyDir = -1
var keyPressed 
var keyReleased

#Bools for keys
var leftPressed = false
var rightPressed = false
var upPressed = false
var downPressed = false

#ref for animator
var animator

#var for global values
var global
func _ready():
	#we get the global node into global
	global = get_node("/root/global")
	animator = get_node("animation")
	#We set our proccess to be active lmao
	set_process(true)
	set_process_input(true)
	pass

func _process(delta):
	get_node("/root/global")._set_player_pos(get_pos())
	_movement(delta)
	_collision()
	pass

#Here i handle all the key input and later i call _movement() to move this shit
func _input(event):
	#animator.play("idle")
	_keyPressed(event)
	keyPressed = false
	keyReleased = false
	
	if event.is_action_pressed("left"):
		keyDir = "left"
		keyPressed = true
		animator.play("left")
	elif event.is_action_pressed("right"):
		keyDir = "right"
		animator.play("right")
		keyPressed = true
	elif event.is_action_pressed("up"):
		keyDir = "up"
		keyPressed = true
		animator.play("up")
	elif event.is_action_pressed("down"):
		keyDir = "down"
		keyPressed = true
		animator.play("down")
		
	if event.is_action_released("left") or event.is_action_released("right") or event.is_action_released("up") or event.is_action_released("down"):
		keyReleased = true
		keyDir = -1
		animator.play("idle")
		if leftPressed:
			keyDir = "left"
			animator.play("left")
		elif rightPressed:
			keyDir = "right"
			animator.play("right")
		elif upPressed:
			keyDir = "up"
			animator.play("up")
		elif downPressed:
			keyDir = "down"
			animator.play("down")
		
	

#buffer for the 2nd key press 
func _keyPressed(event):
	if event.is_action_pressed("left"):
		leftPressed = true
	elif event.is_action_pressed("right"):
		rightPressed = true
	elif event.is_action_pressed("up"):
		upPressed = true
	elif event.is_action_pressed("down"):
		downPressed = true
	
	if event.is_action_released("left"):
		leftPressed = false
	elif event.is_action_released("right"):
		rightPressed = false
	elif event.is_action_released("up"):
		upPressed = false
	elif event.is_action_released("down"):
		downPressed = false
	
#Physical movement of the body	
func _movement(delta):
	var pos
	
	if str(keyDir) == "left":
		var pos = get_pos()+(Vector2(-1,0)*velocity*delta)
		move_to(pos)
	elif str(keyDir) == "right":
		var pos = get_pos()+(Vector2(1,0)*velocity*delta)
		move_to(pos)
	elif str(keyDir) == "up":
		var pos = get_pos()+(Vector2(0,-1)*velocity*delta)
		move_to(pos)
	elif str(keyDir) == "down":
		var pos = get_pos()+(Vector2(0,1)*velocity*delta)
		move_to(pos)
		
	#print(keyDir)
	
func _collision():
	if is_colliding():
		for i in get_tree().get_nodes_in_group("mosquitos"):
			if get_collider() == i:
				global._reset_mosquito()
				get_tree().change_scene("res://battle/battle.tscn")
				get_parent().queue_free()
	