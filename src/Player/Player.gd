extends KinematicBody2D

export(int) var speed
export(float) var gravity
export(int) var jumpSpeed

var velocity : Vector2 = Vector2.ZERO
var direction : float

var currentState = null
enum States {IDLE, RUN, JUMP}

func _process(delta):
	
	set_state()


func _physics_process(delta):
	
	pass


func set_state():
	pass
	

