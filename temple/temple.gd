extends Node2D

onready var mosquitoScene = preload("res://mosquito/mosquito.tscn")
var timerSpawn
var lifeTimer
var lifeBar
var numberLife
var global
var sfx
var battleGlobal
var rip
var senseiTimer

func _ready():
	global = get_node("/root/global")
	battleGlobal = get_node("/root/battleGlobal")
	sfx = get_node("/root/sfx")
	sfx._play_ramen_fly_intro()
	sfx._play_grunt()
	rip = get_node("hud/rip")
	rip.set_text("R.I.P MOSQUITOS: "+str(battleGlobal._get_total_mosquitos_killed()))
	numberLife = get_node("hud/Control/numberLife")
	numberLife.set_text(str(round(global._get_life()))+" /100")
	lifeBar = get_node("hud/Control/life")
	lifeBar.set_value(global._get_life())
	timerSpawn = get_node("timers/mosquitoTimer")
	lifeTimer = get_node("timers/lifeTimer")
	timerSpawn.set_wait_time(global._get_timer_spawn())
	lifeTimer.set_wait_time(global._get_life_timer())
	senseiTimer = get_node("timers/senseiTimer")
	randomize()
	senseiTimer.set_wait_time(rand_range(4,5))
	senseiTimer.start()
	set_process(true)
	pass

func _process(delta):
	_mosquito_counter()
	if global._dead():
		global._reset_game()
		get_tree().change_scene("res://gameOver/gameOver.tscn")
		queue_free()
		

func _mosquito_counter():
	return  get_node("/root/global")._get_mosquitos()
	

func _on_mosquitoTimer_timeout():
	var mosquitoIns = mosquitoScene.instance()
	mosquitoIns.set_pos(Vector2(30,30))
	add_child(mosquitoIns)



func _on_lifeTimer_timeout():
	if _mosquito_counter() != null:
		for i in range(0,_mosquito_counter()):
			global._sub_life()
		lifeBar.set_value(global._get_life())
		numberLife.set_text(str(round(global._get_life()))+" /100")
	

func _on_senseiTimer_timeout():
	sfx._play_grunt()
	randomize()
	senseiTimer.set_wait_time(rand_range(2,5))

