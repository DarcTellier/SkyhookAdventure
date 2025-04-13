extends CharacterBody2D
# Hinkel Dinkheimer

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var horizontal_velocity = 0 

@export var cayote_Time = 10
var cayote_count= 0

@export var input_freeze = false
@export var jump = false
@export var duck_jump_height = 2
@export var up_press = false
@export var down_press = false
@export var left_press = false
@export var right_press = false

var in_pipe_transit = false



#TODO move these 3 to it's own script / do state machine
var two_way_platform = false
var white_platform = false
var white_block_time_start = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready() -> void:
	PauseScreen.player_reff = self #pass refference to self to Pause screen for magic
	GPipeNetwork.emergency_player_reff = self # fix issue with pipe not getting player refference on pipe body enter. 

func _physics_process(delta):
	update_gravity(delta)
	cayote_time()
	player_input()
	
	
		

func player_input():
	if input_freeze == false:
		jump_input()
		movement_input()
		white_block()
		regular_inputs()


func movement_input():
	
	var direction = Input.get_axis("left", "right")
	if direction <0:
		$Sprite.flip_h = true
	elif direction >0 :
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
		

#TODO CLEAN THIS 
func _on_white_block_timer_timeout() -> void:
	position.y+=1
	z_index = -1
	
	
func regular_inputs():
	if Input.is_action_pressed("down"):
		down_press = true
	if Input.is_action_just_released("down"):
		down_press = false	
		
	if Input.is_action_pressed("up"):
		up_press = true
	if Input.is_action_just_released("up"):
		up_press = false	
	
	if Input.is_action_pressed("left"):
		left_press = true
	if Input.is_action_just_released("left"):
		left_press = false	
	
	if Input.is_action_pressed("right"):
		right_press = true
	if Input.is_action_just_released("right"):
		right_press = false	
