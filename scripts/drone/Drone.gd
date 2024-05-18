extends Character

""" 
	This is the parent script which possess variables for move and slide which are 
	modified by states. Also it delegates processes and necessary info to State
	Machine which delegates process to children states according to a transition. 
	It has a implementation for checking lives.
"""

@export var detectionRange: int

var distanceToPlayer : Vector2


@onready var ledgeDetector  : RayCast2D = $LedgeDetector
var ledgeOffset : int = 40

@onready var fieldOfView : RayCast2D = $FieldOfView
var fovCast : int = 400

@onready var sprite : Sprite2D = $Sprite2D

@onready var collider : CollisionShape2D = $CollisionShape2D


@onready var player : CharacterBody2D = get_tree().get_root().find_child("Player", true, false)



func check_lives() -> void:
	if health == 0:
		get_tree().call_group("ScoreText", "gain_score", 200)
		queue_free()
	
func take_damage(_damage : int) -> void:
	super.take_damage(_damage)
	CameraShake.shake(1, 1.1)
	get_tree().call_group("ScoreText", "gain_score", 20)

func _ready() -> void:
	states.enter(self, player) #Passing itself and target


func _process(delta) -> void:
	
	
	check_lives()
	animate()
	
	if is_instance_valid(player):
		distanceToPlayer = (player.global_position - global_position)
	else:
		distanceToPlayer = Vector2.INF
	
	states.logic(delta)

func _physics_process(delta) -> void:
	states.physics_logic(delta)
	
	set_velocity(velocity)
	set_up_direction(Vector2.UP)
	move_and_slide()
	
	states.on_collisions(delta)

func animate() -> void:
	
	if direction > 0:
		sprite.flip_h = true
	elif direction < 0:
		sprite.flip_h = false
