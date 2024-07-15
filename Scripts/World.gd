extends Node2D

@export var PLAYER_VELOCITY = 10
@export var game_stats: GameStats

@onready var score_label: Label = $Score

var Score = 0
var highscore = 0 # setting highscore to 0 here is a bad idea (have to look up how to keep track of it - maybe use global??)
var current_item = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	$MeatPlayer.position = Vector2(1400, 350)
	$VegPlayer.position = Vector2(510, 350)
	update_score_label(game_stats.score)
	game_stats.score_changed.connect(update_score_label)
	# might be nice to put a freeze here and then say the instructions before starting (add this last since we might not have enough time)
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

func _input(event):
	if Input.is_action_pressed("Switch Characters"):
		var temp_state = $VegPlayer.active
		$VegPlayer.active = $MeatPlayer.active
		$MeatPlayer.active = temp_state
			
# add a function that checks if life or mad customer count has reached game end amount and act accordingly
# add functions for player interactions with items

func freeze():
	# make current player frozen
	# go through all the npcs and make them all frozen too
	pass

func unfreeze():
	# unfreeze for the same as above
	pass
	
func update_score_label(new_score: int) -> void:
	score_label.text = "Score: " + str(new_score)
