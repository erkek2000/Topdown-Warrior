extends CharacterBody2D

var SPEED = 50
var is_chasing = false
var chase_target = null
var target_position = null

func _physics_process(delta):
	if is_chasing:
		velocity = position.direction_to(chase_target.position) * SPEED
		move_and_slide()
		
		if (chase_target.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
			
		$AnimatedSprite2D.play("side_move")
	else:
		$AnimatedSprite2D.play("front_idle")

func _on_enemy_detection_area_body_entered(body):
	if body.name == "Player":	
		is_chasing = true
		chase_target = body

func _on_enemy_detection_area_body_exited(body):
	if body.name == "Player":
		is_chasing = false
		chase_target = null
