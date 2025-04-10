extends StaticBody2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.white_platform = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		body.white_platform = false
