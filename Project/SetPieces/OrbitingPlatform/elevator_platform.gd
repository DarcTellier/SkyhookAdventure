@tool
extends PathFollow2D
var direction = 1 


func _ready() -> void:
	loop =  get_parent().loop_mode
	

func _physics_process(delta: float) -> void:
	progress += direction * get_parent().speed
	
	if progress_ratio >= 1 or progress_ratio <= 0:
		direction = -direction
