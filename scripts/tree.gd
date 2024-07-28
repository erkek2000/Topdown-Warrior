extends StaticBody2D

var behindTree = []

func _physics_process(delta):
	if not behindTree.is_empty():
		$Sprite2D.modulate.a8 = 130
	else:
		$Sprite2D.modulate.a8 = 255

func _on_transparency_area_body_entered(body):
	if body.name == "Player":
		behindTree.append(body)
		
	pass


func _on_transparency_area_body_exited(body):
	if body.name == "Player":
		behindTree.erase(body)
		
