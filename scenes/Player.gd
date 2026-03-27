extends CharacterBody2D

@export var speed: int = 400
@export var gravity: int = 1200
@export var jump_speed: int = -400
@export var max_jumps: int = 6

var current_jumps: int = 0
var start_position: Vector2
var is_dead: bool = false

# Map zoom state
var map_zoomed_out: bool = false
const ZOOM_NORMAL := Vector2(1.0, 1.0)
const ZOOM_OUT    := Vector2(0.25, 0.25)

func _ready():
	start_position = global_position

func get_input():
	if is_dead:
		return
	velocity.x = 0

	if is_on_floor():
		current_jumps = 0

	if Input.is_action_just_pressed("jump") and current_jumps < max_jumps:
		velocity.y = jump_speed
		current_jumps += 1

	if Input.is_action_pressed("right"):
		velocity.x += speed
	if Input.is_action_pressed("left"):
		velocity.x -= speed

func _physics_process(delta):
	velocity.y += delta * gravity
	get_input()
	move_and_slide()

func _process(_delta):
	if is_dead:
		return

	# Animasi
	if not is_on_floor():
		$Animator.play("Jump")
	elif velocity.x != 0:
		$Animator.play("Walk")
	else:
		$Animator.play("Idle")

	if velocity.x > 0:
		$Sprite2D.flip_h = false
	elif velocity.x < 0:
		$Sprite2D.flip_h = true

	# --- TOGGLE MAP (M key) ---
	if Input.is_action_just_pressed("toggle_map") and Global.has_map:
		_toggle_map_zoom()

func _toggle_map_zoom():
	map_zoomed_out = !map_zoomed_out
	var camera: Camera2D = $Camera2D
	var target_zoom = ZOOM_OUT if map_zoomed_out else ZOOM_NORMAL
	var tween = create_tween()
	tween.tween_property(camera, "zoom", target_zoom, 0.4)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func kalah():
	if is_dead:
		return
	is_dead = true
	set_physics_process(false)

	if map_zoomed_out:
		map_zoomed_out = false
		$Camera2D.zoom = ZOOM_NORMAL

	Global.lives -= 1

	if Global.lives <= 0:
		Global.lives = 0
		Transition.change_scene_to_file("res://scenes/LoseScreen.tscn")
	else:
		await get_tree().create_timer(0.8).timeout
		global_position = start_position
		velocity = Vector2.ZERO

		var scene = get_tree().get_current_scene()
		for node in scene.get_children():
			if node.has_method("reset"):
				node.reset()

		is_dead = false
		set_physics_process(true)
