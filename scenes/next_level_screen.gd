extends Control

func _ready():
	var title = $MarginContainer/VBoxContainer/TitleLabel
	var subtitle = $MarginContainer/VBoxContainer/SubLabel
	
	title.modulate.a = 0
	subtitle.modulate.a = 0
	
	var tween = create_tween().set_parallel(true)
	tween.tween_property(title, "modulate:a", 1.0, 0.8)
	tween.tween_property(title, "position:y", title.position.y - 20, 0.8).from(title.position.y)
	tween.tween_property(subtitle, "modulate:a", 1.0, 0.6).set_delay(0.6)
	
	await get_tree().create_timer(3.0).timeout
	Transition.change_scene_to_file("res://scenes/Level2.tscn")
