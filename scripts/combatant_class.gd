@icon("res://art/combatant.svg")
class_name Combatant
extends CharacterBody2D

# Movement properties
@export var SPEED : int
#@export var direction : Vector2
@export var is_moving : bool
@export var movable : bool

# Combat properties
@export var health : int
@export var strength : int
@export var is_vulnerable : bool
# Always 0.1 invul_time from knockback
@export var invul_time: float


