extends Sprite2D

var tea: int = -1

# When hovers increse font size, when pressed sets tea flavor to its value
func _ready() -> void:
	for button in get_children():
		if button is BaseButton:
			button.mouse_entered.connect(func():
				var label = button.find_child("Label")
				label.add_theme_font_size_override("font_size", 50)
				)
			button.mouse_exited.connect(func():
				var label = button.find_child("Label")
				label.add_theme_font_size_override("font_size", 40)
				)
			button.pressed.connect(func():
				tea = (int)(button.text)
			)
