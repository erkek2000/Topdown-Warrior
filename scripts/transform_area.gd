extends Area2D
class_name TransformArea


# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("body_entered", Callable(self, "_on_body_entered"))
	self.connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.name == "Player":
		var parent = get_parent()
		_transform(parent)
		
func _on_body_exited(body):
	if body.name == "Player":
		var parent = get_parent()
		_untransform(parent)
		
func _transform(_node):
	pass
	
func _untransform(_node):
	pass
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
