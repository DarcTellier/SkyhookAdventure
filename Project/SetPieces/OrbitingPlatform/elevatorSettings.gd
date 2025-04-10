extends Path2D
@export var speed = 1
@export var num_of_platforms = 10
@export var loop_mode = false
var elevator_length
var platform_offset

func _ready() -> void:
	platform_offset = (curve.get_point_position(1).y - curve.get_point_position(0).y)/ num_of_platforms  
	
	for i in num_of_platforms:
		var scene = load("res://elevator_platform.tscn")
		var scene_instance = scene.instantiate()   
		scene_instance.set_name("Platform"+str(i))
		add_child(scene_instance)
		scene_instance.get_node("Platforms").position.y = platform_offset * i
