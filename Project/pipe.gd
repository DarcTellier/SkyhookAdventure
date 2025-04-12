extends StaticBody2D

var player_reff
var enter_pipe = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.name == "Player":
		player_reff = body


func _process(delta: float) -> void:
	if player_reff != null:
		if player_reff.name == "Player":
			if player_reff.down_press == true && enter_pipe == false:
				enter_pipe = true
				in_the_pipe()
				
				
func in_the_pipe():
	player_reff.input_freeze = true
	player_reff.global_position.x = $Marker2D.global_position.x
	player_reff.z_index = -2
	player_reff.get_node("AnimationPlayer").play("down_the_pipe")
