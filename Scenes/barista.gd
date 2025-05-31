extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var dialog_bubble: TextureRect = $DialogBubble

var dialog_state: int = 0

func dialog():
	match dialog_state:
		0:
			dialog_state = 1
			dialog_bubble.message = "hai"
			dialog_bubble.open()
		1:
			dialog_state = 2
			dialog_bubble.message = "pick flavor"
			animation_player.play("TeaMenu")
			dialog_bubble.open()
		2:
			dialog_state = 3
			dialog_bubble.message = "pick boba"
			animation_player.play("BobaMenu")
			dialog_bubble.open()
		3:
			dialog_state = 0
			dialog_bubble.message = "YIPPEE"
			animation_player.play("ByeMenu")
			dialog_bubble.open()

func _on_button_pressed() -> void:
	#animation_player.play("TeaMenu")
	dialog()


func _on_button_2_pressed() -> void:
	animation_player.play("BobaMenu")
