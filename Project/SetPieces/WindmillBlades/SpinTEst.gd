extends StaticBody2D

@export var direction = true

func _process(delta):
	
	if direction == true :
		rotation_degrees -= 1
	else : 
		rotation_degrees += 1
