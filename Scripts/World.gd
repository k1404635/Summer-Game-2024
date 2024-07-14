extends Node2D

@export var PLAYER_VELOCITY = 10

const SCREEN_WIDTH = 1152
const SCREEN_HEIGHT = 648

var score = 0
var highscore = 0 # setting highscore to 0 here is a bad idea (have to look up how to keep track of it - maybe use global??)
var current_item = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	reset()
	# add_player_interactives()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# NPC handling (look this up)
	
	# handle creating and being able to get food items (look this up too)
	
	# Pausing
	if Input.is_action_just_pressed("Pause"): 
		if $UILayer/PauseMenu.visible:
			$UILayer/PauseMenu.unpause()
			$UILayer/PauseMenu.visible = false
		else:
			$UILayer/PauseMenu.pause()
			$UILayer/PauseMenu.visible = true
			
func reset():
	$MeatPlayer.position = Vector2(950, 200)
	$VegPlayer.position = Vector2(225, 200)
	
	# might be nice to put a freeze here and then say the instructions before starting (add this last since we might not have enough time)

# add a function that checks if life or mad customer count has reached game end amount and act accordingly
# add functions for player interactions with items

func freeze():
	# make current player frozen
	# go through all the npcs and make them all frozen too
	pass

func unfreeze():
	# unfreeze for the same as above
	pass
	
