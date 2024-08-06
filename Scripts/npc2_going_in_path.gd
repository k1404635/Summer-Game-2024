extends PathFollow2D

@export var moveSpeed = 60
@onready var halfway = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(get_progress_ratio() > 0.5 and halfway == false):
		moveSpeed = 0
		$AnimatedSprite2D.play("NPC2BackStill")
	else:
		moveSpeed = 60
	if (get_progress_ratio() < 0.5):
		$AnimatedSprite2D.play("NPC2Back")
	elif (get_progress_ratio() > 0.5 and get_progress_ratio() < 1 and halfway != false):
		$AnimatedSprite2D.play("NPC2Front")
	elif (get_progress_ratio() == 1): # need to add another if statement or something that makes it move again (i.e. moveSpeed = 60 again)
		$AnimatedSprite2D.play("NPC2FrontStill")
		
	set_progress(get_progress() + moveSpeed * delta)
