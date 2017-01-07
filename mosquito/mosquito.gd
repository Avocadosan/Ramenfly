extends KinematicBody2D

var playerPos 
var screenW
var screenH
export (int) var velocity 

func _ready():
	playerPos = get_node("/root/global")._get_player_pos()
	get_node("/root/global")._add_mosquito()
	screenW = OS.get_window_size().x
	screenH = OS.get_window_size().y
	self.add_to_group("mosquitos")
	set_process(true)
	_set_pos()

func _set_pos():
	if playerPos != null:
		randomize()
		var x = rand_range(0,screenW)
		randomize()
		var y = rand_range(0, screenH)
		move(Vector2(x,y))
		

func _process(delta):
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
