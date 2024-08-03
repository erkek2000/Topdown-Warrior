extends Node

class_name NestedNoiseGenerator

@export var base_frequency: float = 1.0
@export var base_amplitude: float = 1.0
@export var octaves: int = 4
@export var persistence: float = 0.5
@export var lacunarity: float = 2.0
#base_frequency: The frequency of the base layer of noise.
#base_amplitude: The amplitude of the base layer of noise.
#octaves: The number of noise layers to combine.
#persistence: Controls how quickly the amplitude decreases for each octave.
#lacunarity: Controls how quickly the frequency increases for each octave.

# Instance of the noise generator (e.g., FastNoiseLite)
@onready var noise = FastNoiseLite.new()

# Function to generate noise using layered frequencies and amplitudes
func generate_noise(x: float, y: float) -> float:
	var total = 0.0
	var frequency = base_frequency
	var amplitude = base_amplitude
	var max_value = 0.0  # Used for normalizing the result

	for i in range(octaves):
		total += _perlin_noise(x * frequency, y * frequency) * amplitude
		max_value += amplitude
		amplitude *= persistence
		frequency *= lacunarity

	return total / max_value  # Normalize the result

# Perlin noise function (using FastNoiseLite)
func _perlin_noise(x: float, y: float) -> float:
	return noise.get_noise_2d(x, y)  # Assuming 'noise' is an instance of a noise generator
