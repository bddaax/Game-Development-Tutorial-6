extends Control

func _ready():
	_animate_in()

func _animate_in():
	var title = $MarginContainer/VBoxContainer/TitleLabel
	title.modulate.a = 0
	var tween = create_tween()
	tween.tween_property(title, "modulate:a", 1.0, 0.6).set_delay(0.1)

func _on_b_level1_pressed():
	Global.lives = 3
	Transition.change_scene_to_file("res://scenes/Level1.tscn")

func _on_b_level2_pressed():
	Global.lives = 3
	Transition.change_scene_to_file("res://scenes/Level2.tscn")

func _on_b_back_pressed():
	Transition.change_scene_to_file("res://scenes/MainMenu.tscn")

func _on_b_level1_mouse_entered():
	_hover($MarginContainer/VBoxContainer/ButtonBox/BLevel1, true)

func _on_b_level1_mouse_exited():
	_hover($MarginContainer/VBoxContainer/ButtonBox/BLevel1, false)

func _on_b_level2_mouse_entered():
	_hover($MarginContainer/VBoxContainer/ButtonBox/BLevel2, true)

func _on_b_level2_mouse_exited():
	_hover($MarginContainer/VBoxContainer/ButtonBox/BLevel2, false)

func _on_b_back_mouse_entered():
	_hover($MarginContainer/VBoxContainer/ButtonBox/BBack, true)

func _on_b_back_mouse_exited():
	_hover($MarginContainer/VBoxContainer/ButtonBox/BBack, false)

func _hover(btn: Control, hovered: bool):
	var tween = create_tween()
	if hovered:
		tween.tween_property(btn, "scale", Vector2(1.06, 1.06), 0.1).set_trans(Tween.TRANS_BACK)
		btn.modulate = Color("ffe066")
	else:
		tween.tween_property(btn, "scale", Vector2(1.0, 1.0), 0.1)
		btn.modulate = Color("ffffff")
