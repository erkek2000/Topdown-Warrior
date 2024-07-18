extends CharacterBody2D

var SPEED = 30
var is_chasing = false
var chase_target = null
var target_position = null

func _physics_process(delta):
	if is_chasing:
		target_position += (chase_target.position - position) / SPEED


func _on_enemy_detection_area_body_entered(body):
	if body.name == "Player":
		is_chasing = true
		chase_target = body

func _on_enemy_detection_area_body_exited(body):
	if body.name == "Player":
		is_chasing = false
		chase_target = null
