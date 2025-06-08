extends AnimatedSprite2D

var cup_size: int = -1 # 0 - small; 1 - medium; 2 - large; 3 - infinicup

func _ready() -> void:
	for button in get_children():
		if button is BaseButton:
			button.pressed.connect(func():
				cup_size = (int)(button.text)
				get_parent().dialog()
				get_parent().next.visible = true
				visible = false
				)
