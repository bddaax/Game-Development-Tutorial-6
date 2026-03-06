extends CharacterBody2D

@export var speed: int = 400
@export var gravity: int = 1200
@export var jump_speed: int = -400
@export var max_jumps: int = 6

var current_jumps: int = 0
var start_position: Vector2 

# Pastikan menggunakan $LoseScreen (besar/kecil hurufnya harus sama persis!)
@onready var lose_screen = $LoseScreen 

func _ready():
	start_position = global_position
	# Sekarang Godot pasti menemukan node-nya dan bisa melakukan hide()
	lose_screen.hide()

func get_input():
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
	if not is_on_floor():
		$Animator.play("Jump")
	elif velocity.x != 0:
		$Animator.play("Walk")
	else:
		$Animator.play("Idle")

	if velocity.x != 0:
		if velocity.x > 0:
			$Sprite2D.flip_h = false
		else:
			$Sprite2D.flip_h = true

# Fungsi ini dipanggil dari script Rintangan
func kalah():
	# 1. Munculkan gambar You Lose
	lose_screen.show()
	
	# 2. Hentikan pergerakan player
	set_physics_process(false)
	
	# 3. Tunggu 2 detik
	await get_tree().create_timer(2.0).timeout
	
	# 4. Pindahkan kembali ke posisi awal
	global_position = start_position
	
	# 5. Sembunyikan gambar You Lose dan izinkan player gerak lagi
	lose_screen.hide()
	set_physics_process(true)


func _on_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
