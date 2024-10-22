extends Node2D

@onready var tile_map = $TileMap
@export var tree_scene: PackedScene  # Exported variable to hold the tree scene
var tree_scene_preloaded = preload("res://scenes/object_scenes/tree_with_areas.tscn")
@onready var player = $Player


const MAP_SIZE = Vector2(128, 128)
const LAND_CAP = 0.1
const TILE_SIZE = 64

# Called when the node enters the scene tree for the first time.
func _ready():
	player.global_position = MAP_SIZE * TILE_SIZE / 2
	await get_tree().create_timer(5).timeout
	generate_world()

func generate_world():
	var noise = FastNoiseLite.new()
	var tree_noise_generator = FastNoiseLite.new()
	noise.seed = randi()
	tree_noise_generator = randi()
	var ground = []
	var water = []
	var cliffs = []
	var sand = []
	
	for x in MAP_SIZE.x:
		for y in MAP_SIZE.y:
			print (x, "   ",  y)
			var a = noise.get_noise_2d(x, y)
			if a >= LAND_CAP:
				ground.append(Vector2(x, y))
			elif a >= 0.05:
				sand.append(Vector2(x, y))
			elif a <= 0.05:
				tile_map.set_cell(0, Vector2(x, y), 8, Vector2(0, 0), 0 )
				#water.append(Vector2(x, y))
				#tile_map.set_cell(0, Vector2(x, y), 8, Vector2(0,0), 0)
			if a > 0.3:
				cliffs.append(Vector2(x, y))
	#Using terrain connect is better since it connects like autotile.
	
	tile_map.set_cells_terrain_connect(0, ground, 0, 0)
	tile_map.set_cells_terrain_connect(0, sand, 1, 0)
	tile_map.set_cells_terrain_connect(0, water, 2, 0)
	tile_map.set_cells_terrain_connect(1, cliffs, 3, 0)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

	
	
	
"""
#@onready var noise_generator = $NoiseGenerator  # Adjust the path to your NestedNoiseGenerator node
@onready var noise_generator = $NestedNoiseGenerator
@onready var tile_map = $TileMap

# Size of the generated map
@export var map_width: int = 100
@export var map_height: int = 100

# Tile size for the TileMap
@export var tile_size: int = 64


# Function to generate the terrain
func _ready():
	generate_terrain()


func generate_terrain():
	var tile_type: int = 0
	for x in range(map_width):
		for y in range(map_height):
			# Generate noise value for the current tile position
			var noise_value = noise_generator.generate_noise(x * 0.1, y * 0.1)  # Scale the input for better variation
			
			# Map the noise value to a height or tile type
			var height = int((noise_value + 1) * 0.5 * tile_size)  # Normalize and scale to tile size
			
			var tile_id = 1  # Replace with the appropriate tile ID based on your tile set
			
			# Calculate the tile position based on the height
			var tile_x = x
			var tile_y = int(height / tile_size)
			
			# Ensure the position is within bounds
			
			tile_map.set_cell(0, Vector2i(tile_x, tile_y), 7, Vector2(0,0), 0)  # Set the tile at the calculated position
			
			
			if noise_value < -0.2:
				tile_type = 0  # Water
			elif noise_value < 0.2:
				tile_type = 1  # Grass
			else:
				tile_type = 2  # Mountain

			#tile_map.set_cellv(Vector2(x, height / tile_size), tile_type)
			
"""
'''
	for x in range(0, MAP_SIZE.x, 5):
		for y in range(0, MAP_SIZE.y, 5):
			# Determine tree placement based on tree noise
			
			var tree_value = tree_noise_generator.get_noise_2d(x, y)  # Scale for tree placement
			if tree_value > 0.2:  # Check if the noise value exceeds the threshold
				var tree_instance = tree_scene_preloaded.instantiate()  # Create an instance of the tree scene
				tree_instance.position = Vector2(x, y)  # Position the tree
				add_child(tree_instance)  # Add the tree to the scene
'''
