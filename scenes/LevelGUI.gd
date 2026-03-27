extends MarginContainer

func _ready():
	pass

func _process(_delta):
	$HBoxContainer/Lives.text = "Lives : " + str(Global.lives)
	
	# Tampilkan hint kontrol sesuai powerup yang dimiliki
	var hints := ""
	if Global.has_map:
		hints += "  [M] Map"
	$HBoxContainer/PowerupHints.text = hints

func _on_b_back_pressed():
	Transition.change_scene_to_file("res://scenes/MainMenu.tscn")

func _on_b_back_mouse_entered():
	$HBoxContainer/BBack.modulate = Color("ddd1ff")

func _on_b_back_mouse_exited():
	$HBoxContainer/BBack.modulate = Color("ffffff")
