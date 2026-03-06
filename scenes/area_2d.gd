extends Area2D

@export var target_scene: String = "res://scenes/Level2.tscn"

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("Pindah ke Level 2!")
		get_tree().change_scene_to_file(target_scene)
