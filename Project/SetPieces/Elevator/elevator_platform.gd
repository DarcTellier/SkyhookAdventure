
extends Node2D

var speed = 100
var drop_off = -936
var max_height = -974

func _process(delta):
	position.y -= speed * delta
	
	if position.y <= drop_off:
		$StaticBody2D/CollisionShape2D.disabled = true
	
	if position.y <= max_height:
		position.y = 0
		$StaticBody2D/CollisionShape2D.disabled = false
