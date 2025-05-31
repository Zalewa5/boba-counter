extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var dialog_bubble: TextureRect = $DialogBubble
@onready var tea_menu: Sprite2D = $TeaMenu
@onready var next: TextureButton = $Next
@onready var another_drink: TextureRect = $AnotherDrink

@export var scene: PackedScene


enum CupStatus {NOT, MAX}
var cup_status = CupStatus.NOT
var dialog_state: int = 0
var cup_count = Global.cups_count

func _ready() -> void:
	dialog()

func dialog():
	match cup_status:
		CupStatus.NOT:
			match dialog_state:
				0:
					cup_count += 1
					Global.cups_count = cup_count
					dialog_state = 1
					dialog_bubble.message = "Time for drink!"
					dialog_bubble.open()
				1:
					dialog_bubble.message = "Pick tea flavor"
					animation_player.play("TeaMenu")
					dialog_bubble.open()
					dialog_state = 2
				2:
					if tea_menu.tea == -1:
						dialog_bubble.message = "Try again!"
						dialog_state = 2
					else:
						dialog_bubble.message = "nice"
						dialog_state = 3
						Global.tea.append(tea_menu.tea)
						tea_menu.tea = -1
					dialog_bubble.open()
				3:
					dialog_state = 4
					dialog_bubble.message = "Pick boba!"
					animation_player.play("BobaMenu")
					dialog_bubble.open()
				4:
					dialog_state = 5
					dialog_bubble.message = "YIPPEE"
					animation_player.play("ByeMenu")
					dialog_bubble.open()
				5:
					dialog_state = 0
					if cup_count >= 4:
						cup_status = CupStatus.MAX
						dialog_bubble.message = "nyo more space ;3c"
						dialog_bubble.open()
					else:
						next.disabled = true
						another_drink.visible = true
					
		CupStatus.MAX:
			match dialog_state:
				0:
					dialog_state = 1
					dialog_bubble.message = "time for drinks ;3"
					dialog_bubble.open()
				1:
					get_tree().change_scene_to_packed(scene)

func _on_next_pressed() -> void:
	dialog()


func _on_yes_pressed() -> void:
	another_drink.visible = false
	next.disabled = false
	dialog()


func _on_no_pressed() -> void:
	cup_status = CupStatus.MAX
	another_drink.visible = false
	next.disabled = false
	dialog()
