extends StaticBody2D

@export var pipe_name = ""
@export var destination = ""

var player_reff
var player_reff_transion
var enter_pipe = false
var inpipetransit = false
var down_press = false


func _ready() -> void:
	if pipe_name == "":
		print_debug("missing pipe name")
	GPipeNetwork.pipe_directory[pipe_name] = $Location_pos.global_position
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if body.name == "Player":
		player_reff = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	
	player_reff = null
	enter_pipe = false
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("down"):
		down_press = true
		print(down_press)

func _process(delta: float) -> void:
	
	if player_reff != null:
		if player_reff.name == "Player":
			if player_reff.down_press == true && enter_pipe == false:
				enter_pipe = true
				print(pipe_name)
				in_the_pipe()
				
				
func in_the_pipe():
	if player_reff.in_pipe_transit == true:
		return
	player_reff.in_pipe_transit = true
	player_reff.input_freeze = true
	

	player_reff.global_position.x = global_position.x
	player_reff.z_index = -2
	player_reff.get_node("AnimationPlayer").play("down_the_pipe")
	
	$InThePipeTimer.start()
	


func _on_timer_timeout() -> void:
	
	player_reff.global_position = GPipeNetwork.pipe_directory[destination]
	player_reff.get_node("AnimationPlayer").play_backwards("up_the_pipe")
	player_reff_transion = player_reff
	$OuThePipeTimer.start()




func _on_ou_the_pipe_timer_timeout() -> void:
	player_reff_transion.in_pipe_transit = false
	player_reff_transion.input_freeze = false
	player_reff_transion.down_press = false
	player_reff_transion = ""
	
	pass # Replace with function body.
