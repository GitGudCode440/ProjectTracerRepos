extends "res://scripts/shared/Level.gd"

@onready var secretArea = $SecretArea

func _on_SecretArea_body_entered(body):
	get_tree().call_group("ScoreText", "gain_score", 500)
	secretArea.disconnect("body_entered", Callable(self, "_on_SecretArea_body_entered"))
	secretArea.queue_free()
