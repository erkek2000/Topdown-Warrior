extends Node
'''
@onready var time_slider = %"Time Slider"  # Adjust the path to your Slider node
var shadow_sprites = []

func _ready():
	# Initialize the slider value based on the first shadow sprite if available
	if shadow_sprites.size() > 0:
		time_slider.value = shadow_sprites[0].time_of_day
	
	# Connect the slider's value_changed signal to the update function
	time_slider.connect("value_changed", Callable(self, "_on_time_slider_value_changed"))

	# Find all SimpleShadowSprite instances in the scene
	for child in get_children():
		if child is SimpleShadowSprite:
			shadow_sprites.append(child)

func _on_time_slider_value_changed(value):
	# Update the time_of_day variable for all shadow sprites
	for shadow_sprite in shadow_sprites:
		shadow_sprite.time_of_day = value
		
		'''
func respawn():
	if get_tree():
		get_tree().reload_current_scene()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
