extends Node

var playerPos
var mosquitoNumber = 0
var rounds = 0
var spawnTimer = 2.5
var lifeTimer = 1.5
var life = 100
var mosquitoDamage = 2.3
var gameEnd = false

func _ready():
	set_process(true)
	
func _process(delta):
	if life <= 0:
		gameEnd = true	
	
func _get_life():
	return life

func _sub_life():
	life -= mosquitoDamage
	
func _sub_life_number(variable = 10):
	life -= variable

func _add_life():
	life += 8
	if life > 100:
		life = 100

func _get_round():
	return rounds
		
func _new_round():
	rounds += 1
	if !(spawnTimer < 0.5):
		spawnTimer -= 0.2
		_reset_mosquito()

func _get_timer_spawn():
	return spawnTimer

func _get_life_timer():
	return lifeTimer

#A handy way to have the player pos :D	
func _set_player_pos(player):
	playerPos = player
	#print(playerPos)

func _get_player_pos():
	return playerPos
	
func _add_mosquito():
	mosquitoNumber += 1
	
func _get_mosquitos():
	return mosquitoNumber

func _reset_mosquito():
	print("reset")
	mosquitoNumber = 0

func _dead():
	return gameEnd

func _reset_game():
	mosquitoNumber = 0
	rounds = 0
	spawnTimer = 2.5
	lifeTimer = 1.5
	life = 100
	mosquitoDamage = 1.2
	gameEnd = false