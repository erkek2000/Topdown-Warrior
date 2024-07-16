extends CharacterBody2D

const SPEED = 150
var direction = "none"
var is_moving = false

func _ready():
	$AnimatedSprite2D.play("front_idle")


func _physics_process(delta):
	player_movement(delta)

func player_movement(delta):
	
	if Input.is_action_pressed("Move Right"):
		direction = "right"
		is_moving = true
		play_anim()
		velocity.x = SPEED
		velocity.y = 0
	elif Input.is_action_pressed("Move Left"):
		direction = "left"
		is_moving = true
		play_anim()
		velocity.x = -SPEED
		velocity.y = 0
	elif Input.is_action_pressed("Move Up"):
		direction = "up"
		is_moving = true
		play_anim()
		velocity.y = -SPEED
		velocity.x = 0
	elif Input.is_action_pressed("Move Down"):
		direction = "down"
		is_moving = true
		play_anim()
		velocity.y = SPEED
		velocity.x = 0
	else:
		play_anim()
		is_moving = false
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()
	

func play_anim():
	var anim = $AnimatedSprite2D
	
	if direction == "right":
		anim.flip_h = false
		if is_moving:
			anim.play("side_run")
		elif not is_moving:
			anim.play("side_idle")
	elif direction == "left":
		anim.flip_h = true
		if is_moving:
			anim.play("side_run")
		elif not is_moving:
			anim.play("side_idle")
	elif direction == "down":
		anim.flip_h = false
		if is_moving:
			anim.play("front_run")
		elif not is_moving:
			anim.play("front_idle")
	elif direction == "up":
		anim.flip_h = false
		if is_moving:
			anim.play("back_run")
		elif not is_moving:
			anim.play("back_idle")
		


"""
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
"""

