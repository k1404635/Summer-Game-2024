extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(get_parent().get_progress_ratio() > 0.5 and get_parent().halfway == false):
		$progress.visible = true
		$OrderBubble.visible = true
		$progress.value = $progress.value - $progress.step
