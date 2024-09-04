extends Sprite2D  # Change this back to Sprite2D if you want to handle both animated and static sprites
class_name SimpleShadowSprite

@export var shadow_opacity := 0.5
@export var shadow_y_stretch := 1.5
@export var y_sort_offset := 0
@export var time_of_day := 0.4  # Global time variable (0.0 to 1.0)

func _ready():
	var parent = get_parent()
	if parent is Sprite2D:
		# If the parent is a Sprite2D, set the texture and properties
		texture = parent.texture
		region_enabled = parent.region_enabled
		region_rect = parent.region_rect
		centered = parent.centered
		offset = parent.offset
		frame = 0  # Static sprite always uses frame 0
	elif parent is AnimatedSprite2D:
		# If the parent is an AnimatedSprite2D, set the initial texture
		update_shadow_texture(parent)
	
	# Set modulate with a constant alpha value
	modulate = Color(0, 0, 0, shadow_opacity)  # Set the shadow color and opacity
	update_scale()
	
	# Ensure the parent is set up for Y-sort
	if parent is Node2D and not parent.is_y_sort_enabled():
		push_warning("SimpleShadowSprite: Parent node is not Y-sorted. Consider enabling Y-sort on the parent or its container.")

func _process(_delta):
	var parent = get_parent()
	if parent is Node2D:
		global_position = parent.global_position
		position.y += y_sort_offset
		z_index = -1  # Ensure shadow is always drawn below the parent sprite
	
	# Handle flipping for both Sprite2D and AnimatedSprite2D
	if parent is Sprite2D or parent is AnimatedSprite2D:
		flip_h = parent.flip_h
		flip_v = parent.flip_v
		if parent is AnimatedSprite2D:
			frame = parent.frame  # Use the current frame from AnimatedSprite2D
			update_shadow_texture(parent)  # Update shadow texture based on the current frame
		else:
			frame = 0  # Static sprite always uses frame 0

	# Update shadow rotation based on time of day
	update_shadow_rotation()

func update_shadow_texture(animated_sprite: AnimatedSprite2D):
	if animated_sprite:
		var current_animation = animated_sprite.animation  # Get the current animation name
		if current_animation:
			var current_frame_index = animated_sprite.frame  # Get the current frame index
			var sprite_frames = animated_sprite.get_sprite_frames()
			# Set the texture to the shadow sprite based on the current frame's texture
			texture = sprite_frames.get_frame_texture(current_animation, current_frame_index)
			region_enabled = true
			region_rect = Rect2(0, 0, texture.get_size().x, texture.get_size().y)  # Use the size of the current frame
		else:
			region_enabled = false  # Disable region if no animation is found
			region_rect = Rect2()  # Create an empty Rect2 if no current frame is available

func update_scale():
	scale = Vector2(1.0, shadow_y_stretch)

func set_shadow_y_stretch(new_stretch: float):
	shadow_y_stretch = new_stretch
	update_scale()

func set_y_sort_offset(new_offset: float):
	y_sort_offset = new_offset

func update_shadow_rotation():
	# Rotate the shadow based on the time of day
	# Assuming time_of_day ranges from 0.0 (midnight) to 1.0 (next midnight)
	var rotation_angle = time_of_day * 360.0  # Convert to degrees
	rotation_degrees = rotation_angle
