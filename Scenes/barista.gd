extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var dialog_bubble: TextureRect = $DialogBubble
@onready var tea_menu: Sprite2D = $TeaMenu
@export var scene: PackedScene

enum CupStatus {NOT, MAX}
var cup_status = CupStatus.NOT
var dialog_state: int = 0
var cup_count = Global.cups_count

func dialog():
	match cup_status:
		CupStatus.NOT:
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
						tea_menu.tea = -1
					dialog_bubble.open()
				3:
					dialog_state = 4
					dialog_bubble.message = "pick boba"
					animation_player.play("BobaMenu")
					dialog_bubble.open()
				4:
					dialog_state = 0
					dialog_bubble.message = "YIPPEE"
					animation_player.play("ByeMenu")
					dialog_bubble.open()
					cup_count += 1
					Global.cups_count = cup_count
					if cup_count >= 4:
						cup_status = CupStatus.MAX
		CupStatus.MAX:
			match dialog_state:
				0:
					dialog_state = 1
					dialog_bubble.message = "nyo more space ;3c"
					dialog_bubble.open()
				1:
					get_tree().change_scene_to_packed(scene)

func _on_next_pressed() -> void:
	dialog()
