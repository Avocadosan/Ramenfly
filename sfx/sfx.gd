extends Node

onready var sfxScn = preload("res://sfx/sfx.tscn")
var sfxIns

var ramenFlyIntro
var gameOver
var mosquitoDie
var gruntOne
var gruntTwo
var gruntThree
var hit
var celeb
var ahh
var letsJam
var sensei
var ramenFly

func _ready():
	sfxIns = sfxScn.instance()
	add_child(sfxIns)
	#refs to sounds
	ramenFlyIntro = sfxIns.get_node("ramenFlyIntro")
	mosquitoDie = sfxIns.get_node("mosquitoDie")
	gruntOne = sfxIns.get_node("sensei/gruntOne")
	gruntTwo = sfxIns.get_node("sensei/gruntTwo")
	gruntThree = sfxIns.get_node("sensei/GruntThree")
	hit = sfxIns.get_node("ramenFly/hit")
	celeb = sfxIns.get_node("ramenFly/celeb")
	ahh = sfxIns.get_node("ramenFly/ahh")
	letsJam = sfxIns.get_node("ramenFly/letsJam")
	sensei = sfxIns.get_node("ramenFly/sensei")
	ramenFly = sfxIns.get_node("ramenFly/ramenFly")
	gameOver = sfxIns.get_node("gameOver")
	
	
func _play_ramen_fly_intro():
	if gameOver.is_playing():
		gameOver.stop()
	if !ramenFlyIntro.is_playing():
		ramenFlyIntro.play()
		
func _play_mosquito_die():
	mosquitoDie.play()

func _play_grunt():
	if hit.is_playing():
		hit.stop()
	randomize()
	var random = randi()%3
	if random == 0:
		gruntOne.play()
	elif random ==1:
		gruntTwo.play()
	else:
		gruntThree.play()
	
func _play_hit():
	hit.play()
	
func _play_celeb():
	if hit.is_playing():
		hit.stop()
	celeb.play()
	
func _play_ahh():
	if hit.is_playing():
		hit.stop()
	ahh.play()
	
func _play_lets_jam():
	letsJam.play()
	
func _play_sensei():
	if gruntOne.is_playing():
		gruntOne.stop()
	elif gruntTwo.is_playing():
		gruntTwo.stop()
	elif gruntThree.is_playing():
		gruntThree.stop()
	sensei.play()

func _play_ramen_fly():
	ramenFly.play()
	
func _play_game_over():
	if ramenFlyIntro.is_playing():
		ramenFlyIntro.stop()
	gameOver.play()