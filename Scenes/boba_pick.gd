extends Node2D

@onready var balls: = $VBoxContainer/Buttons/Balls
@onready var boba_pick: Node = $"."

var bobaNumber: int = -1

func _on_confirm_pressed() -> void:
	if(bobaNumber > -1):
		get_parent().find_child("CupAndMenu").visible = true
		boba_pick.visible = false


func _ready():
	for button in balls.get_children():
		if button is BaseButton:
			var value = button.get_meta("value") as int
			button.pressed.connect(func():
				bobaNumber = value
				print("Number set to:", bobaNumber)
				)
