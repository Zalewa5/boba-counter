extends Node2D

@onready var jelly: PackedScene = preload("res://Objects/jelly.tscn")
@onready var popping: PackedScene = preload("res://Objects/popping.tscn")
@onready var boba_spawn: Node2D = $CupAndMenu/Container/BobaSpawn
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var boba_count: int = 0 # How many bobas there are
var scene_num: int # Which cup it is
var cup_size: int # size of the cup 0 - small; 1 - medium; 2 - large; 3 - infinicup
var boba_types: Array # Array with values 0-6 being popping and 7-10 being jelly
var boba_tastes: Array # Array with values coresponding to frame of correct taste of boba
var rng := RandomNumberGenerator.new()

# Spawns random boba from selection moving it a little & updates number of bobas on cup
func _on_plus_pressed() -> void:
	match cup_size:
		0:
			if boba_count < 25:
				spawn_boba("S")
		1:
			if boba_count < 50:
				spawn_boba("M")
		2:
			if boba_count < 100:
				spawn_boba("L")
		3:
			spawn_boba("L")

# Deletes last added boba
func _on_minus_pressed() -> void:
	match cup_size:
		0:
			delete_boba("S")
		1:
			delete_boba("M")
		2:
			delete_boba("L")
		3:
			delete_boba("L")

func delete_boba(size: String) -> void:
	if boba_spawn.get_children().size()-1 >= 0:
		var child = boba_spawn.get_child(boba_spawn.get_children().size()-1)
		if(child != null):
			boba_spawn.remove_child(child)
			child.queue_free()
			boba_count -= 1
			find_child(size).find_child("BobaCount", true, false).text = str(boba_count)
		
func spawn_boba(size: String) -> void:
	var boba
	var id: int = rng.randi_range(0,boba_types.size()-1)
	var boba_type = boba_types.get(id)
	if (boba_type < 7):
		boba = popping.instantiate()
		boba.find_child("Sprite").frame = boba_tastes.get(id)
	else:
		boba = jelly.instantiate()
		boba.find_child("Sprite").frame = boba_tastes.get(id)
	boba.rotation += randi() % 360
	boba.position.x += randi() % 100 - 50
	boba.position.y += randi() % 100 - 50
	boba_spawn.add_child(boba)
	boba_count += 1
	find_child(size).find_child("BobaCount", true, false).text = str(boba_count)

func _ready() -> void:
	cup_size = Global.cup_size.get(scene_num)
	match cup_size:
		0:
			animation_player.play("S_cup_drop")
		1:
			animation_player.play("M_cup_drop")
		2:
			animation_player.play("L_cup_drop")
		3:
			animation_player.play("L_cup_drop")
	boba_types = Global.boba_type.get(scene_num)
	boba_tastes = Global.boba_taste.get(scene_num)
