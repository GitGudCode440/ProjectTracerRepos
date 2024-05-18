extends Area2D
class_name Bullet

@export var speed: int
@export var damage: int

var direction : Vector2

func _ready():
	set_as_top_level(true)
	global_position = get_parent().global_position
	
func _physics_process(delta):
	
	
	position += direction * speed
	
	

func set_direction(_direction) -> void:
	
	direction = _direction
	
	var angleOfRotation = Vector2.RIGHT.angle_to(direction)
	
	$Sprite2D.rotate(angleOfRotation)
	$CollisionShape2D.rotate(angleOfRotation)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
	
func _on_Bullet_body_entered(body):
	
	if body.has_method("take_damage"):
		body.call_deferred("take_damage", damage) 
	
	queue_free()
	
