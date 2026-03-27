extends CanvasLayer

func show_message(text: String):
	$PanelContainer/MarginContainer/Label.text = text
	
	# Start invisible
	$PanelContainer.modulate = Color(1, 1, 1, 0)
	
	# Animate in
	var tween = create_tween()
	tween.tween_property($PanelContainer, "modulate", Color(1, 1, 1, 1), 0.3)
	
	# Wait
	tween.tween_interval(3.0)
	
	# Animate out
	tween.tween_property($PanelContainer, "modulate", Color(1, 1, 1, 0), 0.5)
	
	await tween.finished
	queue_free()
