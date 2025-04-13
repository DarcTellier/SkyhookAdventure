extends Node2D
@export var speed = 1


func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		move_wall()

func move_wall():
	var tween = create_tween()
	tween.tween_property($AnimatableBody2D,"position",$End.position,speed).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.play()
