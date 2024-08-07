extends PathFollow2D

@export var moveSpeed = 60
@export var halfway = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(get_progress_ratio() > 0.5 and halfway == false):
		moveSpeed = 0
		$AnimatedSprite2D.play("NPC2BackStill")
		$order.visible = true
	else:
		moveSpeed = 60
		$order.visible = false 
		
	if (get_progress_ratio() < 0.5):
		$AnimatedSprite2D.play("NPC2Back")
	elif (get_progress_ratio() > 0.5 and get_progress_ratio() < 1 and halfway != false):
		$AnimatedSprite2D.play("NPC2Front")
	elif (get_progress_ratio() == 1): # need to add another if statement or something that makes it move again (i.e. moveSpeed = 60 again)
		$AnimatedSprite2D.play("NPC2FrontStill")
		
	set_progress(get_progress() + moveSpeed * delta)


func _on_timer_timeout():
	if get_progress_ratio() > 0.5 and halfway == false:
		$order/progress.value -= 1
	if  $order/progress.value == 0:
		halfway = true
		Global.lives -= 1
		if Global.lives <= 0:
			get_tree().change_scene_to_file("res://Scenes/game_over_screen.tscn")
