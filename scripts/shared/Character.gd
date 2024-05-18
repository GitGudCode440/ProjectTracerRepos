extends CharacterBody2D
class_name Character

@export var health: int
@export var speed: int
@export var gravity: float

var direction : float = 1.0

@onready var states : Node = $States
@onready var damageSound : AudioStreamPlayer = $DamageSound

func take_damage(_damage : int) -> void:
	health -= _damage
	damageSound.play()
	


