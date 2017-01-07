extends KinematicBody2D

var isInArea = false
var down = false
var velocity

func _ready():
	get_node("/root/battleGlobal")._add_mosquito()
	set_process_input(true)
	set_process(true)
	randomize()
	velocity = rand_range(100,180)
	pass

func _input(event):
	if event.is_action_pressed("leftClick") and isInArea and down:
		get_node("/root/battleGlobal")._sub_mosquito()
		queue_free()

func _process(delta):
	if Input.is_action_pressed("down"):
		down = true
	else:
		down = false
	
	randomize()
	var random = randi()%4
	if random == 0:
		move_to(get_pos()+(Vector2(-1,0)*velocity*delta))
	if random == 1:
		move_to(get_pos()+(Vector2(1,0)*velocity*delta))
	if random == 2:
		move_to(get_pos()+(Vector2(0,-1)*velocity*delta))
	if random == 3:
		move_to(get_pos()+(Vector2(0,1)*velocity*delta))

func _on_Area2D_area_enter( area ):
	isInArea = true


func _on_Area2D_area_exit( area ):
	isInArea = false

