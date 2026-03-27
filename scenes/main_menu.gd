extends Control

@export var bplay_scene_to_load: String = "Level1"
@export var blevel_scene_to_load: String = "LevelSelect"

# Walking player
var player_direction: int = 1
var player_speed: float = 120.0
var walk_left: float = 50.0
var walk_right: float = 1050.0

@onready var walking_player = $SubViewportContainer/SubViewport/WalkingPlayer

func _ready():
	Global.lives = 3
	Global.has_map = false
	_animate_title()

func _process(delta):
	if walking_player == null:
		return
	walking_player.position.x += player_speed * player_direction * delta
	if walking_player.position.x >= walk_right:
		player_direction = -1
		if walking_player.has_node("Sprite2D"):
			walking_player.get_node("Sprite2D").flip_h = true
	elif walking_player.position.x <= walk_left:
		player_direction = 1
		if walking_player.has_node("Sprite2D"):
			walking_player.get_node("Sprite2D").flip_h = false

func _animate_title():
	var title = $MarginContainer/VBoxContainer/TitleLabel
	var subtitle = $MarginContainer/VBoxContainer/SubtitleLabel
	title.modulate.a = 0
	subtitle.modulate.a = 0
	var tween = create_tween().set_parallel(true)
	tween.tween_property(title, "modulate:a", 1.0, 0.8).set_delay(0.2)
	tween.tween_property(title, "position:y", title.position.y, 0.6)\
		.from(title.position.y + 30).set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_BACK).set_delay(0.2)
	tween.tween_property(subtitle, "modulate:a", 1.0, 0.6).set_delay(0.8)

func _on_b_play_pressed():
	Transition.change_scene_to_file("res://scenes/" + bplay_scene_to_load + ".tscn")

func _on_b_level_pressed():
	Transition.change_scene_to_file("res://scenes/" + blevel_scene_to_load + ".tscn")

func _on_b_play_mouse_entered():
	_hover_button($MarginContainer/VBoxContainer/ButtonBox/BPlay, true)

func _on_b_play_mouse_exited():
	_hover_button($MarginContainer/VBoxContainer/ButtonBox/BPlay, false)

func _on_b_level_mouse_entered():
	_hover_button($MarginContainer/VBoxContainer/ButtonBox/BLevel, true)

func _on_b_level_mouse_exited():
	_hover_button($MarginContainer/VBoxContainer/ButtonBox/BLevel, false)

func _hover_button(btn: Control, hovered: bool):
	var tween = create_tween()
	if hovered:
		tween.tween_property(btn, "scale", Vector2(1.06, 1.06), 0.1)\
			.set_trans(Tween.TRANS_BACK)
		btn.modulate = Color("ffe066")
	else:
		tween.tween_property(btn, "scale", Vector2(1.0, 1.0), 0.1)
		btn.modulate = Color("ffffff")
