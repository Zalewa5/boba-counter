extends Node2D

const CUP_SCENE: PackedScene = preload("res://Scenes/cup_scene.tscn")

func _ready() -> void:
	var pos = 1800/Global.cups_count
	for n in Global.tea.size():
		var cup = CUP_SCENE.instantiate()
		self.add_child(cup)
		var val = Global.tea.get(n)
		cup.find_child("Flavor", true, false).frame = val
		cup.position.x = ((n*pos + (n+1)*pos) / 2) + 60
		cup.position.y = 0
		
