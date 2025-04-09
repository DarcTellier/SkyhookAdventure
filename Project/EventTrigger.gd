extends Node2D
@export var trigger_type = "stop_scroll"





func _on_area_2d_body_entered(body):
	event_type()
	
	pass 


func event_type():
	match trigger_type:
		"scroll":get_node("/root/Main/Camera2D").style_select = 3
		"dynamic": get_node("/root/Main/Camera2D").style_select = 1
		"follow": get_node("/root/Main/Camera2D").style_select = 2
		
		
	get_node("/root/Main/Camera2D").camera_room_correction_x()
	get_node("/root/Main/Camera2D").camera_room_correction_y()	
