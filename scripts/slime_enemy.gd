extends Combatant


var is_chasing : bool = false
var chase_target = null
var target_position = null
var inside_damaging_area = []


func _ready():
	# Movement properties
	SPEED = 50
	# Combat properties
	health = 50
	strength = 3
	is_vulnerable = true
	invul_time = 1


func _physics_process(delta):
	
	while not inside_damaging_area.is_empty():
		inside_damaging_area[0].hurt(strength, position)
		await get_tree().create_timer(delta).timeout
	
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


func _on_damaging_area_body_entered(body):
	if body.name == "Player":
		inside_damaging_area.append(body)
			
func _on_damaging_area_body_exited(body):
	if inside_damaging_area.has(body):
			inside_damaging_area.erase(body)
