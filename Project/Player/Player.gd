extends CharacterBody2D
# Hinkel Dinkheimer

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0

@export var cayote_Time = 10
var cayote_count= 0

@export var jump = false


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	
	if is_on_floor() == true:
		jump = true
		cayote_count = 0
	
	else:
		cayote_count += 1
		if cayote_count >= cayote_Time:
			jump = false
			pass




	# Handle Jump.
	if Input.is_action_just_pressed("jump")&& jump == true :   #and is_on_floor()
		velocity.y = JUMP_VELOCITY
		$AudioStreamPlayer2D.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction == -1:
		$Sprite.flip_h = true
	elif direction == 1:
		$Sprite.flip_h = false
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
