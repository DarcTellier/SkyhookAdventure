extends CanvasLayer


func _input(event: InputEvent) -> void:
	if visible == true:
		if event.is_action_pressed("interact"):
			hide()
