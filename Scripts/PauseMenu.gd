extends Control

func _unhandled_input(event):
	if event.is_action_pressed("Pause"):
		self.is_paused = !is_paused

var is_paused = false:
	set(value):
		is_paused = value
		get_tree().paused = is_paused
		visible = is_paused

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_resume_pressed():
	self.is_paused = false

func _on_main_menu_pressed():
	# get_tree().quit()
	self.is_paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
