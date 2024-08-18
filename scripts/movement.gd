'''
extends Node2D

@export var SPEED: int = 100
var direction
var is_moving 


# Called when the node enters the scene tree for the first time.
func _ready():
	var parent = get_parent()
	
	if parent.name == "Player":
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
		
	else:
		#Add navmesh stuff
		pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
'''
