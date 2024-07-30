extends TransformArea

# for completely hiding objects like roofs when Player entered the building.
func _transform(node):
	node.hide()
	
func _untransform(node):
	node.show()
