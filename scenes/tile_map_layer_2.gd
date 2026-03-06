extends TileMapLayer

@export var speed: float = 150.0
@export var max_height: float = 2600.0 # Seberapa jauh dia boleh naik (dalam pixel)

var is_moving: bool = false
var start_y: float = 0.0

func _ready():
	# Catat posisi awal biar kita tahu batas naiknya
	start_y = position.y

func _physics_process(delta):
	if is_moving:
		# Hanya gerak kalau belum melewati batas atas
		if position.y > start_y - max_height:
			position.y -= speed * delta
		else:
			position.y = start_y - max_height # Pasin di batas atas
			is_moving = false # Berhenti kalau sudah sampai

func _on_area_2d_body_entered(body):
	# Gunakan 'is CharacterBody2D' agar lebih fleksibel dibanding cek nama
	if body is CharacterBody2D: 
		is_moving = true

func _on_area_2d_body_exited(body):
	if body is CharacterBody2D:
		# Opsional: kalau mau dia tetap di atas, jangan ubah is_moving jadi false di sini
		pass
