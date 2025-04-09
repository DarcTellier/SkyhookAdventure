extends Area2D

var animation_speed = 2
var animation_count = 0

func _process(_delta):
	animation_count += 1
	if animation_count >= animation_speed:
		$Sprite2D.frame += 1 
		animation_count = 0 
	
	
	
	if $Sprite2D.frame >= 60:
		$Sprite2D.frame = 0



func _on_body_entered(_body):
	$AudioStreamPlayer2D.play()
	visible = false
	$CollisionShape2D.disabled = true
	


func _on_audio_stream_player_2d_finished():
	queue_free()
	
