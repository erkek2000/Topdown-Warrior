extends Sprite2D
class_name SimpleShadowSprite

@export var shadow_offset := Vector2(5, 5)
@export var shadow_opacity := 0.5
@export var shadow_top_offset := Vector2(0, -20)

var original_size: Vector2

func _ready():
	copy_parent_properties()
	set_shadow_properties()
	calculate_original_size()

func copy_parent_properties():
	var parent = get_parent()
	if parent is Sprite2D:
		texture = parent.texture
		region_enabled = parent.region_enabled
		region_rect = parent.region_rect
		centered = parent.centered
		offset = parent.offset

func set_shadow_properties():
	modulate = Color(0, 0, 0, shadow_opacity)
	position = shadow_offset

func calculate_original_size():
	if region_enabled and region_rect:
		original_size = region_rect.size
	elif texture:
		original_size = texture.get_size()
	else:
		push_warning("SimpleShadowSprite: No texture found on parent Sprite2D.")
		original_size = Vector2.ONE

func _process(delta):
	update_shadow_transform()

func update_shadow_transform():
	var parent = get_parent()
	if parent is Sprite2D:
		global_position = parent.global_position + shadow_offset.rotated(parent.global_rotation)
		global_rotation = parent.global_rotation
		flip_h = parent.flip_h
		flip_v = parent.flip_v
		if parent.is_in_group("animated"):
			frame = parent.frame
		else:
			frame = 0
		update_shadow_shape()

func update_shadow_shape():
	if original_size == Vector2.ZERO:
		push_warning("SimpleShadowSprite: Original size is zero.")
		return

	var viewport = get_viewport()
	if not viewport:
		return

	var base_point = Vector2(0, original_size.y / 2) if centered else Vector2(0, original_size.y)
	var top_point = base_point + shadow_top_offset

	var local_base = to_local(global_position + base_point.rotated(global_rotation))
	var local_top = to_local(global_position + top_point.rotated(global_rotation))

	scale = Vector2.ONE
	region_enabled = true
	region_rect = Rect2(0, 0, original_size.x, original_size.y)

	var new_size = Vector2(original_size.x, local_base.distance_to(local_top))
	var new_scale = Vector2(1, new_size.y / original_size.y)
	var pivot = Vector2(0.5, 1) if centered else Vector2(0.5, 0)
	
	scale = new_scale
	offset = (pivot - Vector2(0.5, 0.5)) * original_size * new_scale

func set_shadow_top_offset(new_offset: Vector2):
	shadow_top_offset = new_offset
	update_shadow_shape()
'''
# Called when the node enters the scene tree for the first time.
func _ready():
	var parent = get_parent()
	castShadow(parent)
	
func castShadow(node):
	if node.Texture is not 0:
		node.Texture
	pass
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
'''
