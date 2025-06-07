extends Node2D

const CUP_SCENE: PackedScene = preload("res://Scenes/cup_scene.tscn")

func _ready() -> void:
	#test_bar()
	# Calculate positions for cups
	var pos = 1800/Global.cups_count
	
	# Create cups, assign them numbers, set position, assign flavor sprite value & text on cup's label
	for n in Global.tea.size():
		var cup = CUP_SCENE.instantiate()
		cup.scene_num = n
		self.add_child(cup)
		var val = Global.tea.get(n)
		cup.find_child("Flavor", true, false).frame = val
		cup.position.x = ((n*pos + (n+1)*pos) / 2) + 60
		cup.position.y = 0
		
		val = Global.cup_name.get(n)
		cup.find_child("CupLabelText", true, false).text = val
		

func test_bar() -> void:
	Global.cups_count = 1
	Global.tea.append(0)
	Global.boba_taste.append([0,0])
	Global.boba_type.append([7,1])
	Global.cup_name.append("test")
