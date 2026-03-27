extends CanvasLayer

var overlay: ColorRect

func _ready() -> void:
	# Create a full-screen black overlay for fade transitions
	layer = 10
	overlay = ColorRect.new()
	overlay.color = Color(0, 0, 0, 0)
	overlay.set_anchors_preset(Control.PRESET_FULL_RECT)
	overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(overlay)

func change_scene_to_file(target: String) -> void:
	# Fade out (black)
	var tween = create_tween()
	tween.tween_property(overlay, "color:a", 1.0, 0.3)
	await tween.finished
	get_tree().change_scene_to_file(target)
	# Fade in (clear)
	var tween2 = create_tween()
	tween2.tween_property(overlay, "color:a", 0.0, 0.3)
