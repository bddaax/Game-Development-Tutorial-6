extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.lives += 1
		
		# Tampilkan popup
		var popup_scene = load("res://scenes/PopupMessage.tscn")
		if popup_scene:
			var popup = popup_scene.instantiate()
			body.get_tree().current_scene.add_child(popup)
			popup.show_message("+1 Nyawa Ekstra!")
			
		var tween = create_tween().set_parallel(true)
		tween.tween_property(self, "scale", Vector2(1.5, 1.5), 0.15)
		tween.tween_property(self, "modulate:a", 0.0, 0.15)
		await tween.finished
		queue_free()
