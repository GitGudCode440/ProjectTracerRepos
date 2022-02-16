extends KinematicBody2D

export(int) var speed
export(float) var gravity

var velocity : Vector2 = Vector2.ZERO
var direction : float

onready var ledgeDetector  : RayCast2D = $LedgeDetector
var ledgeOffset : int = 20

onready var fieldOfView : RayCast2D = $FieldOfView
onready var player : KinematicBody2D = get_tree().get_root().find_node("Player", true, false)

func _ready():
	
	direction = 1
	
func _process(delta):
	change_direction()
	detect_objects()
	
	
func _physics_process(delta):
	
	velocity.x = direction * speed
	detect_objects()
	move_and_slide(velocity, Vector2.UP)
	
	
	on_collsion_wall()
	
	apply_gravity()
	
	
func change_direction() -> void:
	
	if !ledgeDetector.is_colliding() and is_on_floor():
		direction = -direction
		change_offset()
	
func detect_objects() -> void:
	
	
	
	if global_position.distance_to(player.global_position) < 200:
		fieldOfView.enabled = true
		
		print(fieldOfView.get_collider())
		
		if fieldOfView.get_collider() == player:
			#Code goes here
			pass
	

func change_offset() -> void:
	
	ledgeDetector.position.x = ledgeOffset * direction
	fieldOfView.cast_to.x *= direction


func on_collsion_wall() -> void:
	
	if is_on_wall():
		direction = -direction


func apply_gravity() -> void:
	
	if !is_on_floor():
		velocity.y += gravity
	else:
		velocity.y = 1
	
