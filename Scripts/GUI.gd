extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Global.lives == 3):
		$Life1.visible = true
		$Life2.visible = true
		$Life3.visible = true
	elif (Global.lives == 2):
		$Life1.visible = true
		$Life2.visible = true
		$Life3.visible = false
	elif (Global.lives == 1):
		$Life1.visible = true
		$Life2.visible = false
		$Life3.visible = false
	elif (Global.lives == 0): # it shouldn't ever need to do this since it should just go to game over screen, but putting this here just in case
		$Life1.visible = false
		$Life2.visible = false
		$Life3.visible = false
