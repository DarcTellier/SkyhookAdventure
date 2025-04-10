extends CharacterBody2D
# Hinkel Dinkheimer

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var horizontal_velocity = 0 

@export var cayote_Time = 10
var cayote_count= 0

@export var jump = false
@export var duck_jump_height = 2
var two_way_platform = false
var white_platform = false
var white_block_time_start = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	update_gravity(delta)
	cayote_time()
	player_input()
	

func player_input():
	jump_input()
	movement_input()
	white_block()
	


func movement_input():
	
	var direction = Input.get_axis("left", "right")
	if direction == -1:
		$Sprite.flip_h = true
	elif direction == 1:
		$Sprite.flip_h = false
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x,horizontal_velocity, SPEED) 

	move_and_slide()


func jump_input():
	#2wayPlatforms
	if Input.is_action_pressed("down")&&Input.is_action_just_pressed("jump")&& jump == true && two_way_platform == true:
		position.y+=1
		$AudioStreamPlayer2D.play()
		return
	#small jump
	if Input.is_action_pressed("down")&&Input.is_action_just_pressed("jump")&& jump == true:
		velocity.y = JUMP_VELOCITY / duck_jump_height
		$AudioStreamPlayer2D.play()
		return	
	
	
	# Handle Jump.
	if Input.is_action_just_pressed("jump")&& jump == true :  
		z_index = 0 # white block 
		velocity.y = JUMP_VELOCITY
		$AudioStreamPlayer2D.play()

func white_block():
	if Input.is_action_pressed("down") && white_platform == true:
		if white_block_time_start == false:
			$White_Block_Timer.start()
			white_block_time_start = true
	else:
		$White_Block_Timer.stop()
		white_block_time_start = false 
		

func update_gravity(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
		
func cayote_time():
	if is_on_floor() == true:
		jump = true
		cayote_count = 0
	
	else:
		cayote_count += 1
		if cayote_count >= cayote_Time:
			jump = false
			pass
		


func _on_white_block_timer_timeout() -> void:
	position.y+=1
	z_index = -1
	
	
