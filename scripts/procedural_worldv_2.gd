extends Node2D

@onready var groundTiles = $Tiles/Ground
@onready var cliffTiles = $Tiles/Cliffs2x
@onready var player = $Player

@export var tree_scene: PackedScene  # Exported variable to hold the tree scene

var tree_scene_preloaded = preload("res://scenes/object_scenes/tree_with_areas.tscn")


const MAP_SIZE := Vector2(128, 128)
const TILE_SIZE := 64

const LAND_CAP := 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	player.global_position = MAP_SIZE * TILE_SIZE / 2
	await get_tree().create_timer(5).timeout
	generate_world()
	pass # Replace with function body.


func generate_world():
	var noise = FastNoiseLite.new()
	var tree_noise_generator = FastNoiseLite.new()
	noise.seed = randi()
	tree_noise_generator = randi()
	var ground = []
	var water = []
	var cliffs = []
	var sand = []
	
	for x in range(0, MAP_SIZE.x, TILE_SIZE):
		for y in range(0, MAP_SIZE.y, TILE_SIZE):
			var a = noise.get_noise_2d(x, y)
			
			if a >= LAND_CAP:
				ground.append(Vector2(x, y))
				
			elif a >= 0.05:
				sand.append(Vector2(x, y))
				
			elif a <= 0.05:
				groundTiles.set_cell(Vector2(x, y), 14, Vector2(0, 0), 0)
				#water.append(Vector2(x, y))
				
			if a > 0.3:
				cliffs.append(Vector2(x, y))
				
	#Using terrain connect is better since it connects like autotile.
	groundTiles.set_cells_terrain_connect(0, ground, 0, 0)
	groundTiles.set_cells_terrain_connect()
	groundTiles.set_cells_terrain_connect(0, sand, 1, 0)
	groundTiles.set_cells_terrain_connect(0, water, 2, 0)
	cliffTiles.set_cells_terrain_connect(1, cliffs, 3, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
