extends Sprite2D

var boba_type: Array[int] = Array([], TYPE_INT, "", null)
var boba_taste: Array[int] = Array([], TYPE_INT, "", null)

# When boba is picked it adds its type & taste to arrays and turns on selection background
# When boba is unpicked it deletes its type & taste from arrays and turns off selection background
func _ready() -> void:
	for button in get_children():
		if button is BaseButton:
			button.toggled.connect(func(toggled_on):
				if toggled_on:
					var type = button.get_meta("type") as int
					boba_type.append(type)
					boba_taste.append(button.text as int)
					button.find_child("Selection", true, false).visible = true
				else:
					var type = button.get_meta("type") as int
					var id = boba_type.find(type)
					if id > -1:
						boba_type.remove_at(id)
						boba_taste.remove_at(id)
						button.find_child("Selection", true, false).visible = false
				)
			button.mouse_entered.connect(func():
				var label = button.find_child("Label")
				label.add_theme_font_size_override("font_size", 56)
				)
			button.mouse_exited.connect(func():
				var label = button.find_child("Label")
				label.add_theme_font_size_override("font_size", 48)
				)
			

# Hides selection background of all buttons
func clean() -> void:
	for button in get_children():
		if button is BaseButton:
			button.find_child("Selection", true, false).visible = false
			button.button_pressed = false
