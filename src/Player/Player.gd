extends KinematicBody2D

""" 
	This is used for move and sliding kinematic body according to variables
	defined by input. It is also where shooting and animation mechanisms are
	implemented. Also has a life system
"""

export(int) var lives

export(int) var speed
export(int) var jumpSpeed

export(float) var gravity

onready var states : Node = $States

var velocity : Vector2 = Vector2.ZERO
var direction : float

var bullet : Resource = preload("res://src/Bullet/PlayerBullet/PlayerBullet.tscn")

onready var animatedSprite : AnimatedSprite = $AnimatedSprite

func take_damage() -> void: #Called by enemies to inflict damage on Player
	
	lives -= 1

func check_lives() -> void:
	if lives == 0:
		get_tree().reload_current_scene()
		
	
func _ready():
	
	states.enter()


func _process(delta) -> void:
	
	check_lives()
	
	
	direction = (Input.get_action_strength("right") - Input.get_action_strength("left"))
	
	states.logic(delta)
	
	if global_position.y > 4000:
		get_tree().reload_current_scene()
	
func _physics_process(delta) -> void:
	
	states.physics_logic()
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	states.on_collisions()
	
	

	

	

	

	
	
