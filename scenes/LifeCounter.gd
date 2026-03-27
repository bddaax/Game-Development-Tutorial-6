extends Label

var prev_lives: int = -1

func _process(_delta):
	var current = Global.lives
	self.text = "Lives : " + str(current)
	if prev_lives != -1 and current < prev_lives:
		_shake()
	prev_lives = current

func _shake():
	var tween = create_tween()
	var origin = position
	tween.tween_property(self, "position", origin + Vector2(6, 0), 0.05)
	tween.tween_property(self, "position", origin - Vector2(6, 0), 0.05)
	tween.tween_property(self, "position", origin + Vector2(4, 0), 0.04)
	tween.tween_property(self, "position", origin - Vector2(4, 0), 0.04)
	tween.tween_property(self, "position", origin, 0.03)
