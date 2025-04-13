extends Node2D
#TODO REdo the code

@export var open_time = 21
@export var close_time = 22



@export var open = false
@export var close = false



var bridge_angle =1

# Called when the node enters the scene tree for the first time.
func _ready():
	#close = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	time_check()
	open_bridge()
	close_bridge()
	pass



func open_bridge():
	
	if bridge_angle <= 90 && close == true:
		bridge_angle +=1
		$LeftBridge.rotation_degrees -=1
		$RightBridge.rotation_degrees +=1
	else:
		close = false	
	
	
	

func close_bridge():
	if bridge_angle >= 2 && open == true:
		bridge_angle -=1
		$LeftBridge.rotation_degrees +=1
		$RightBridge.rotation_degrees -=1
	else:
		open = false	
	


func time_check():
	
	if int(Time.get_time_dict_from_system().hour) == close_time:
		open = true
		
	if int(Time.get_time_dict_from_system().hour) == open_time:
		close = true
	
