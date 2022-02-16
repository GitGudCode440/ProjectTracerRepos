extends KinematicBody2D

export(int) var speed
export(float) var gravity

var velocity : Vector2 = Vector2.ZERO
var direction : float

onready var ledgeDetector  : RayCast2D = $LedgeDetector
var ledgeOffset : int = 20

onready var fieldOfView : RayCast2D = $FieldOfView
onready var player : KinematicBody2D = get_tree().get_root().find_node("Player", true, false)

