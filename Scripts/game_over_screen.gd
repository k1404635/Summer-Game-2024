extends Control

@onready var GLOBAL = get_node("/root/Global")

# Called when the node enters the scene tree for the first time.
func _ready():
	$GameOverMusic.play()
	var fade = get_tree().create_tween()
	fade.tween_property($FadeAway, "color", Color(0, 0, 0, 0), 5)
	await get_tree().create_timer(5).timeout

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_to_main_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_try_again_pressed():
	GLOBAL.reset()
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
