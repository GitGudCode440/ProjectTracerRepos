extends "res://scripts/shared/Level.gd"


func _on_SecretArea_body_entered(body):
	get_tree().call_group("ScoreText", "gain_score", 500)
