extends Area2D
class_name Bullet

export(int) var speed

var direction : Vector2

func _ready():
	set_as_toplevel(true)
	global_position = get_parent().global_position

func _physics_process(delta):
	
	position += direction * speed

func set_direction(_direction) -> void:
	
	direction = _direction
	
	var angleOfRotation = Vector2.RIGHT.angle_to(direction)
	
	$Sprite.rotate(angleOfRotation)
	$CollisionShape2D.rotate(angleOfRotation)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
