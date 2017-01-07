extends Node
onready var sfx = get_node("/root/sfx")
var flyAway
var mosquitoNumber = 0
var rounds = 0
var level = 0
var timerSpawn = 0.8
var mosquitosToKill = 0
onready var global = get_node("/root/global")
var totalMosquitosKilled = 0

func _timer_spawn():
	for i in range(0,global._get_round()):
		if timerSpawn > 0.3:
			timerSpawn -= 0.05
		else:
			timerSpawn = 0.3
	return timerSpawn

func _get_fly_away():
	if global._get_round() < 6:
		randomize()
		return 10-rand_range(0,global._get_round())
	else:
		return 6

func _start_battle():
	rounds = global._get_round()
	mosquitosToKill = rounds+round(rand_range(1,3))
	if mosquitosToKill > 10:
		mosquitosToKill = 10
	#print(mosquitosToKill)
	if rounds == 0:
		level = 0
	elif rounds >= 1 and rounds < 3:
		level = 1
	elif rounds >= 3 and rounds < 7:
		level = 2
	elif rounds >=7 and rounds < 11:
		level = 3
	elif rounds >=11:
		level = 4
	
func _get_level():
	return level

func _reset_battle():
	flyAway = 100
	mosquitoNumber = 0
	level = 0

func _sub_mosquito():
	mosquitosToKill -= 1
	totalMosquitosKilled += 1
	sfx._play_mosquito_die()
func _add_mosquito():
	pass
	
func _get_total_mosquitos_killed():
	return totalMosquitosKilled
	
func _get_mosquitos_to_kill():
	return mosquitosToKill