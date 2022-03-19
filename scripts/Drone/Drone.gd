extends KinematicBody2D

""" 
	This is the parent script which possess variables for move and slide which are 
	modified by states. Also it delegates processes and necessary info to State
	Machine which delegates process to children states according to a transition. 
	It has a implementation for checking lives.
"""

export(int) var lives
export(int) var speed
export(float) var gravity

export(int) var detectionRange

var distanceToPlayer : Vector2

var velocity : Vector2 = Vector2.ZERO
var direction : float

onready var ledgeDetector  : RayCast2D = $LedgeDetector
var ledgeOffset : int = 20

onready var fieldOfView : RayCast2D = $FieldOfView
var fovCast : int = 400

onready var collider : CollisionShape2D = $CollisionShape2D

onready var states : Node = $States

onready var player : KinematicBody2D = get_tree().get_root().find_node("Player", true, false)

func _ready() -> void:
	states.enter(self, player) #Passing itself and target

func _process(delta) -> void:
	check_lives()
	
	distanceToPlayer = (player.global_position - global_position)
	
	if distanceToPlayer.length() < detectionRange:
		fieldOfView.enabled = true
	else:
		fieldOfView.enabled = false
	
	states.logic(delta)

func _physics_process(delta) -> void:
	states.physics_logic(delta)
	
	move_and_slide(velocity, Vector2.UP)
	
	states.on_collisions(delta)

func take_damage() -> void:
	lives -= 1

func check_lives() -> void:
	if lives == 0:
		queue_free()
