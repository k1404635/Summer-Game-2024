extends Control

@onready var score: Label = $Background/score

# Called when the node enters the scene tree for the first time.
func _ready():	
	$FadeAway.visible = true
	var fade = get_tree().create_tween()
	fade.tween_property($FadeAway, "color", Color("00000000"), 1.0)
	
	var audio = get_tree().create_tween()
	audio.tween_property($MainMenuMusic, "volume_db", 0, 1.0)

func _on_start_game_pressed():
	var fade = get_tree().create_tween()
	fade.tween_property($FadeAway, "color", Color("#000000ff"), 1.0)
	
	var audio = get_tree().create_tween()
	audio.tween_property($MainMenuMusic, "volume_db", -50, 1.0)
	
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
