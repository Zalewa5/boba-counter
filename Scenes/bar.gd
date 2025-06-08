extends Node2D

@onready var pause_menu: Control = $PauseMenu
@onready var cups: Node = $Cups

const CUP_SCENE: PackedScene = preload("res://Scenes/cup_scene.tscn")
var size_letter: String
var paused: bool = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pause()

func pause():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	paused = !paused

func _ready() -> void:
	#test_bar()
	# Calculate positions for cups
	var pos = 1800/Global.cups_count
	
	# Create cups, assign them numbers, set position, assign flavor sprite value & text on cup's label
	for n in Global.tea.size():
		var cup = CUP_SCENE.instantiate()
		cup.scene_num = n
		cups.add_child(cup)
		var size_num = Global.cup_size.get(n)
		var val = Global.tea.get(n)
		match size_num:
			0:
				size_letter = "S"
			1:
				size_letter = "M"
			2:
				size_letter = "L"
			3:
				size_letter = "L"
		
		cup.find_child(size_letter, true, false).find_child("Flavor", true, false).frame = val
		cup.position.x = ((n*pos + (n+1)*pos) / 2) + 60
		cup.position.y = 0
		
		val = Global.cup_name.get(n)
		cup.find_child(size_letter, true, false).find_child("CupLabelText", true, false).text = val
		

func test_bar() -> void:
	Global.cups_count = 1
	Global.cup_size.append(3)
	Global.tea.append(0)
	Global.boba_taste.append([0,0])
	Global.boba_type.append([7,1])
	Global.cup_name.append("something longer")
