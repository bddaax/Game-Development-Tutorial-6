extends Area2D

# Scene tujuan saat player mencapai trigger ini (pintu akhir level)
@export var target_scene: String = "res://scenes/Level2.tscn"

func _on_Area_Trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.lives = 3  # Reset nyawa saat masuk level baru
		var current = get_tree().current_scene.name
		var next_target = target_scene
		
		# Routing dinamis: tambahkan layar transisi untuk Level 1
		if current == "Level1":
			next_target = "res://scenes/NextLevelScreen.tscn"
		elif current == "Level2":
			next_target = "res://scenes/WinScreen.tscn"
			
		print("Pindah ke: " + next_target)
		Transition.change_scene_to_file(next_target)
