extends TransformArea

# For making objects transparent like when player walks behidn a tree.
func _transform(node):
	_fade(node)
	
func _untransform(node):
	_unfade(node)

func _can_fade(node):
	return "modulate" in node

func _fade(node):
	if _can_fade(node):
		node.modulate.a = 0.5
	else:
		for child in node.get_children():
			_fade(child)

func _unfade(node):
	if _can_fade(node):
		node.modulate.a = 1
	else:
		for child in node.get_children():
			_unfade(child)
	
