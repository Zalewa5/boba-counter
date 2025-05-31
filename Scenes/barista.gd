extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var dialog_bubble: TextureRect = $DialogBubble
@onready var tea_menu: Sprite2D = $TeaMenu
@export var scene: PackedScene

var dialog_state: int = 0

func dialog():
	match dialog_state:
		0:
			dialog_state = 1
			dialog_bubble.message = "hai"
			dialog_bubble.open()
		1:
			dialog_bubble.message = "pick flavor"
			animation_player.play("TeaMenu")
			dialog_bubble.open()
			dialog_state = 2
		2:
			if tea_menu.tea == -1:
				dialog_bubble.message = "try again"
				dialog_state = 2
			else:
				dialog_bubble.message = "nice"
				dialog_state = 3
				Global.tea.append(tea_menu.tea)
				Global.cups_count += Global.cups_count + 1
				tea_menu.tea = -1
			dialog_bubble.open()
		3:
			dialog_state = 4
			dialog_bubble.message = "pick boba"
			animation_player.play("BobaMenu")
			dialog_bubble.open()
		4:
			dialog_state = 5
			dialog_bubble.message = "YIPPEE"
			animation_player.play("ByeMenu")
			dialog_bubble.open()
		5:
			get_tree().change_scene_to_packed(scene)

func _on_button_pressed() -> void:
	#animation_player.play("TeaMenu")
	dialog()


func _on_button_2_pressed() -> void:
	animation_player.play("BobaMenu")
