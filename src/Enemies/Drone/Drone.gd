extends KinematicBody2D

export(int) var speed
export(float) var gravity

var velocity : Vector2 = Vector2.ZERO
var direction : float

onready var player : KinematicBody2D = get_tree().get_root().find_node("Player", true, false)

onready var ledgeDetector  : RayCast2D = $LedgeDetector
var ledgeOffset : int = 20

onready var fieldOfView : RayCast2D = $FieldOfView
var fovCast : int = 400

onready var collider : CollisionShape2D = $CollisionShape2D

onready var states : Node = $States

func _ready():
	states.enter(self, player)

func _process(delta):
	states.logic(delta)

func _physics_process(delta):
	states.physics_logic(delta)
	
	move_and_slide(velocity, Vector2.UP)
	
	states.on_collisions(delta)
