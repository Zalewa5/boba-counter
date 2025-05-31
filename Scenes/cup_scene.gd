extends Node2D

@onready var jelly: PackedScene = preload("res://Objects/jelly.tscn")
@onready var popping: PackedScene = preload("res://Objects/popping.tscn")
@onready var boba_spawn: Node2D = $CupAndMenu/Container/BobaSpawn
@onready var boba_count_label: Label = $CupAndMenu/Container2/Cup/BobaCount
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var boba_count: int = 0 # How many bobas there are
var scene_num: int # Which cup it is
var boba_types: Array # Array with values 0-6 being popping and 7-10 being jelly
var boba_tastes: Array # Array with values coresponding to frame of correct taste of boba
var rng := RandomNumberGenerator.new()

func _on_plus_pressed() -> void:
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
	boba_count_label.text = str(boba_count)


func _on_minus_pressed() -> void:
	var child = boba_spawn.get_child(boba_spawn.get_children().size()-1)
	if(child != null):
		boba_spawn.remove_child(child)
		child.queue_free()
		boba_count -= 1
		boba_count_label.text = str(boba_count)


func _ready() -> void:
	animation_player.play("cup_drop")
	boba_types = Global.boba_type.get(scene_num)
	print(boba_types)
	boba_tastes = Global.boba_taste.get(scene_num)
