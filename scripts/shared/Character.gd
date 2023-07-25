extends KinematicBody2D
class_name Character

export(int) var lives
export(int) var speed
export(float) var gravity

var velocity : Vector2 = Vector2.ZERO
var direction : float = 1.0

onready var states : Node = $States
onready var damageSound : AudioStreamPlayer = $DamageSound

func take_damage() -> void:
	lives -= 1
	damageSound.play()
	


