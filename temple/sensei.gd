extends RigidBody2D

var wordList = ["I can't stand this anymore!", "Pls make it stop dude!", "Frecking Mosquitos!","I can't bear this burden!","Pls kill them dude","I'm going to die, help","Ayy boi gonna kill ya fam","SAO REALLY SUCKS DUDE","OMAE O CHIN CHIN GA DAISUKI"]

func _ready():
	randomize()
	var phrase = wordList[randi()%wordList.size()-1]
	get_node("Label").set_text(phrase)
	pass

