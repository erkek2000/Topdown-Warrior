extends Node2D

@onready var groundTiles = $Tiles/Ground
@onready var cliffTiles = $Tiles/Cliffs2x
@onready var player = $Player

@export var tree_scene: PackedScene  # Exported variable to hold the tree scene

#var tree_scene_preloaded = preload("res://scenes/object_scenes/small_tree_with_areas.tscn")


const MAP_SIZE := Vector2(128, 128)
const TILE_SIZE := 64

const LAND_CAP := 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	player.global_position = MAP_SIZE * TILE_SIZE / 2
	#await get_tree().create_timer(5).timeout
	generate_world()
	pass # Replace with function body.
	
	
func generate_world():
	var noise = FastNoiseLite.new()
	var tree_noise = FastNoiseLite.new()
	noise.seed = randi()
	tree_noise.seed = randi()
	print (noise.seed ,"\n", tree_noise.seed)
	var ground = []
	var water = []
	var cliffs = []
	var sand = []
	var tree_positions = []
	
	for x in range(MAP_SIZE.x):
		for y in range(MAP_SIZE.y):
			
			var a = noise.get_noise_2d(x, y)
			var b = tree_noise.get_noise_2d(x, y)
			
			if a > 0.3:
				cliffs.append(Vector2(x, y))
				
			if a >= LAND_CAP:
				ground.append(Vector2(x, y))
				if b > 0.1 and a < 0.3:
					#var tree_instance = tree_scene_preloaded.instantiate()  # Create an instance of the tree scene
					#tree_instance.global_position = Vector2(x, y)  # Position the tree
					#tree_instance.scale = Vector2(5, 5)
					#add_child(tree_instance)  # Add the tree to the scene
					tree_positions.append(Vector2(x, y))  # Collect tree positions
			
			elif a >= 0.05:
				sand.append(Vector2(x, y))
				
			elif a <= 0.05:
				groundTiles.set_cell(Vector2(x, y), 14, Vector2(0, 0), 0)
				#water.append(Vector2(x, y))
				
				
	#Using terrain connect is better since it connects like autotile.
	groundTiles.set_cells_terrain_connect(ground, 0, 0)
	groundTiles.set_cells_terrain_connect(sand, 0, 1)
	#groundTiles.set_cells_terrain_connect(water, 0, 2)
	cliffTiles.set_cells_terrain_connect(cliffs, 0, 0)
	
			

	# Instantiate trees after collecting positions
	for index in range(tree_positions.size()):
		var pos = tree_positions[index]
		if index % 5 == 0:
			var tree_instance = tree_scene.instantiate()  # Create an instance of the tree scene
			tree_instance.position = pos * TILE_SIZE  # Position the tree
			tree_instance.scale = Vector2(5, 5)
			add_child(tree_instance)  # Add the tree to the scene
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
