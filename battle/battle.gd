extends Node2D
#global variables
var battleGlobal
var global
var sfx

#move hand boolean and appear animation
var handIsActive = false
var appearHand

#spawn timer ref
var spawnTimer 

#flyAway timer
var flyAwayTimer
var flyAwayBar
var boolFlyAway = false

#failed animation
var failedAnimation

#win animation
var winAnimation

#bool win animation
var boolWinAnimation = false

#scenes ref
onready var blackMosquitoScn = preload("res://battle/mosquitos/blackMosquito.tscn")
onready var greenMosquitoScn = preload("res://battle/mosquitos/greenMosquito.tscn")
onready var redMosquitoScn = preload("res://battle/mosquitos/redMosquito.tscn")
onready var whiteMosquitoScn = preload("res://battle/mosquitos/whiteMosquito.tscn")
onready var yellowMosquitoScn = preload("res://battle/mosquitos/yellowMosquito.tscn")

func _ready():
	global = get_node("/root/global")
	battleGlobal = get_node("/root/battleGlobal")
	sfx = get_node("/root/sfx")
	sfx._play_lets_jam()
	appearHand = get_node("animations/appearHand")
	spawnTimer = get_node("timers/spawnTimer")
	spawnTimer.set_wait_time(battleGlobal._timer_spawn())
	flyAwayTimer = get_node("timers/flyAway")
	flyAwayTimer.set_wait_time(battleGlobal._get_fly_away())
	print(battleGlobal._get_fly_away())
	flyAwayBar = get_node("hud/flyAway")
	failedAnimation = get_node("failed/failedAnimation")
	winAnimation = get_node("win/WinAnimation")
	battleGlobal._reset_battle()
	battleGlobal._start_battle()
	_clear_mosquitos()
	set_process(true)
	set_process_input(true)
	pass
	
func _input(event):
	if event.is_action_pressed("leftClick") and handIsActive:
		sfx._play_hit()

	
func _process(delta):
	_move_hand()
	_set_before_game_timer()
	_set_mosquito_count()
	_fly_away_bar()

func _fly_away_bar():
	if boolFlyAway:
		var multi = 100/flyAwayTimer.get_wait_time()
		flyAwayBar.set_value(flyAwayTimer.get_time_left()*multi)
		if flyAwayBar.get_value() < 0.1:
			#print("ayy_lmao")
			boolFlyAway = false
			handIsActive = false
			spawnTimer.stop()
			get_node("hud/z/mosquitoCount").set_opacity(0)
			failedAnimation.play("failed")
			sfx._play_ahh()

#I clear al the mosquitos for the last scene
func _clear_mosquitos():
	for i in get_tree().get_nodes_in_group("mosquitos"):
		i.queue_free()

#here I move the hand
func _move_hand():
	if handIsActive:
		Input.set_mouse_mode(1)
		get_node("hand/Position2D").set_pos(get_global_mouse_pos())
		get_node("hand/Sprite").set_pos(get_node("hand/Position2D").get_pos())

func _set_before_game_timer():
	get_node("beforeGame/Label").set_text(str(get_node("timers/beforegame").get_time_left()))
	
func _set_mosquito_count():
	var mosquitoCount = get_node("hud/z/mosquitoCount")
	mosquitoCount.set_text("Kill "+str(battleGlobal._get_mosquitos_to_kill())+" Mosquitos!")
	if battleGlobal._get_mosquitos_to_kill() <= 0:
		if !boolWinAnimation:
			boolWinAnimation = true	
			boolFlyAway = false
			flyAwayTimer.stop()
			spawnTimer.stop()
			handIsActive = false
			get_node("hud/z/mosquitoCount").set_opacity(0)
			winAnimation.play("win")
			sfx._play_celeb()
		
		

func _on_beforeGameAnimation_finished():
	handIsActive = true
	appearHand.play("appearHand")
	spawnTimer.start()
	flyAwayTimer.start()
	boolFlyAway = true
	get_node("hud/z").set_opacity(1)
	
func _on_spawnTimer_timeout():
	_spawn_mosquitos()

func _on_failedAnimation_finished():
	global._new_round()
	global._sub_life_number()
	get_tree().change_scene("res://temple/temple.tscn")
	queue_free()

func _on_WinAnimation_finished():
	global._new_round()
	global._add_life()
	get_tree().change_scene("res://temple/temple.tscn")
	queue_free()

#copy&paste madness lmao, sorry bout that
func _spawn_mosquitos():
	var level = battleGlobal._get_level()
	#first level
	if level == 0:
		var mosquitoInstance = blackMosquitoScn.instance()
		mosquitoInstance.add_to_group("mosquitoBattle")
		randomize()
		mosquitoInstance.set_pos(Vector2(randi()%640,randi()%480))
		add_child(mosquitoInstance)
	#second level
	elif level == 1:
		randomize()
		var random = randi()%2
		if random == 0:
			var mosquitoInstance = blackMosquitoScn.instance()
			mosquitoInstance.add_to_group("mosquitoBattle")
			randomize()
			mosquitoInstance.set_pos(Vector2(randi()%640,randi()%480))
			add_child(mosquitoInstance)
		elif random == 1:
			var mosquitoInstance = greenMosquitoScn.instance()
			mosquitoInstance.add_to_group("mosquitoBattle")
			randomize()
			mosquitoInstance.set_pos(Vector2(randi()%640,randi()%480))
			add_child(mosquitoInstance)
	#third level
	elif level == 2:
		randomize()
		var random = randi()%3
		if random == 0:
			var mosquitoInstance = blackMosquitoScn.instance()
			mosquitoInstance.add_to_group("mosquitoBattle")
			randomize()
			mosquitoInstance.set_pos(Vector2(randi()%640,randi()%480))
			add_child(mosquitoInstance)
		elif random == 1:
			var mosquitoInstance = greenMosquitoScn.instance()
			mosquitoInstance.add_to_group("mosquitoBattle")
			randomize()
			mosquitoInstance.set_pos(Vector2(randi()%640,randi()%480))
			add_child(mosquitoInstance)
		elif random == 2:
			var mosquitoInstance = redMosquitoScn.instance()
			mosquitoInstance.add_to_group("mosquitoBattle")
			randomize()
			mosquitoInstance.set_pos(Vector2(randi()%640,randi()%480))
			add_child(mosquitoInstance)
	#fourth level
	elif level == 3:
		randomize()
		var random = randi()%4
		if random == 0:
			var mosquitoInstance = blackMosquitoScn.instance()
			mosquitoInstance.add_to_group("mosquitoBattle")
			randomize()
			mosquitoInstance.set_pos(Vector2(randi()%640,randi()%480))
			add_child(mosquitoInstance)
		elif random == 1:
			var mosquitoInstance = greenMosquitoScn.instance()
			mosquitoInstance.add_to_group("mosquitoBattle")
			randomize()
			mosquitoInstance.set_pos(Vector2(randi()%640,randi()%480))
			add_child(mosquitoInstance)
		elif random == 2:
			var mosquitoInstance = redMosquitoScn.instance()
			mosquitoInstance.add_to_group("mosquitoBattle")
			randomize()
			mosquitoInstance.set_pos(Vector2(randi()%640,randi()%480))
			add_child(mosquitoInstance)
		elif random == 3:
			var mosquitoInstance = whiteMosquitoScn.instance()
			mosquitoInstance.add_to_group("mosquitoBattle")
			randomize()
			mosquitoInstance.set_pos(Vector2(randi()%640,randi()%480))
			add_child(mosquitoInstance)
	#you get the idea...
	elif level == 4:
		randomize()
		var random = randi()%5
		if random == 0:
			var mosquitoInstance = blackMosquitoScn.instance()
			mosquitoInstance.add_to_group("mosquitoBattle")
			randomize()
			mosquitoInstance.set_pos(Vector2(randi()%640,randi()%480))
			add_child(mosquitoInstance)
		elif random == 1:
			var mosquitoInstance = greenMosquitoScn.instance()
			mosquitoInstance.add_to_group("mosquitoBattle")
			randomize()
			mosquitoInstance.set_pos(Vector2(randi()%640,randi()%480))
			add_child(mosquitoInstance)
		elif random == 2:
			var mosquitoInstance = redMosquitoScn.instance()
			mosquitoInstance.add_to_group("mosquitoBattle")
			randomize()
			mosquitoInstance.set_pos(Vector2(randi()%640,randi()%480))
			add_child(mosquitoInstance)
		elif random == 3:
			var mosquitoInstance = whiteMosquitoScn.instance()
			mosquitoInstance.add_to_group("mosquitoBattle")
			randomize()
			mosquitoInstance.set_pos(Vector2(randi()%640,randi()%480))
			add_child(mosquitoInstance)
		elif random == 4:
			var mosquitoInstance = yellowMosquitoScn.instance()
			mosquitoInstance.add_to_group("mosquitoBattle")
			randomize()
			mosquitoInstance.set_pos(Vector2(randi()%640,randi()%480))
			add_child(mosquitoInstance)	

