extends Node2D
@onready var tile_map = $TileMap

const MAP_SIZE = Vector2(128, 128)
const LAND_CAP = 0.3


# Called when the node enters the scene tree for the first time.
func _ready():
	generate_world()

func generate_world():
	var noise = FastNoiseLite.new()
	noise.seed = randi()
	
	var cells = []
	for x in MAP_SIZE.x:
		for y in MAP_SIZE.y:
			var a = noise.get_noise_2d(x, y)
			if a < LAND_CAP:
				cells.append(Vector2(x, y))
			else:
				tile_map.set_cell(0, Vector2(x, y), 8, Vector2(0,0), 0)
				
	tile_map.set_cells_terrain_connect(0, cells, 0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
