extends PathFollow2D

@export var moveSpeed = 60

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_progress(get_progress() + moveSpeed * delta)
	$AnimatedSprite2D.play("NPC1Back")
	if (get_progress_ratio() == 1):
		$AnimatedSprite2D.play("NPC1BackStill")
