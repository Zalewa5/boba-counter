extends Node2D

const CUP_SCENE: PackedScene = preload("res://Scenes/cup_scene.tscn")

func _ready() -> void:
	var cup_number = 4
	for n in cup_number:
		var cup = CUP_SCENE.instantiate()
		add_child(cup)
		cup.position.x = n*450+60
		cup.position.y = 0
		
