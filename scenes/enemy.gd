extends CharacterBody2D

@export var speed: float = 80.0
@export var patrol_distance: float = 200.0

var start_position: Vector2
var direction: int = 1
var health: int = 1

func _ready():
	start_position = global_position

func _physics_process(delta):
	velocity.x = speed * direction
	move_and_slide()

	# Balik arah saat sudah mencapai batas patrol
	if global_position.x >= start_position.x + patrol_distance:
		direction = -1
		$Sprite2D.flip_h = true
	elif global_position.x <= start_position.x - patrol_distance:
		direction = 1
		$Sprite2D.flip_h = false

# Dipanggil saat kena peluru
func hit():
	health -= 1
	if health <= 0:
		# Efek kecil sebelum mati
		var tween = create_tween()
		tween.tween_property(self, "modulate:a", 0.0, 0.2)
		await tween.finished
		queue_free()
	else:
		# Flicker effect
		modulate = Color(1, 0.3, 0.3)
		await get_tree().create_timer(0.1).timeout
		modulate = Color(1, 1, 1)

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.kalah()
