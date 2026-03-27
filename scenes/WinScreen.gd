extends Control

func _ready():
	pass

func _on_b_main_menu_pressed():
	Transition.change_scene_to_file("res://scenes/MainMenu.tscn")

func _on_b_main_menu_mouse_entered():
	$MarginContainer/HBoxContainer/HBoxContainer/VBoxContainer/BMainMenu.modulate = Color("ddd1ff")

func _on_b_main_menu_mouse_exited():
	$MarginContainer/HBoxContainer/HBoxContainer/VBoxContainer/BMainMenu.modulate = Color("ffffff")

func _on_b_restart_pressed():
	Global.lives = 3
	Transition.change_scene_to_file("res://scenes/Level1.tscn")

func _on_b_restart_mouse_entered():
	$MarginContainer/HBoxContainer/HBoxContainer/VBoxContainer/BRestart.modulate = Color("ddd1ff")

func _on_b_restart_mouse_exited():
	$MarginContainer/HBoxContainer/HBoxContainer/VBoxContainer/BRestart.modulate = Color("ffffff")
