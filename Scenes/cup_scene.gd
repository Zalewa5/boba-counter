extends Node2D

@onready var jelly: PackedScene = preload("res://Objects/jelly.tscn")
@onready var popping: PackedScene = preload("res://Objects/popping.tscn")
@onready var boba_spawn: Node2D = $CupAndMenu/Container/BobaSpawn
@onready var boba_count_label: Label = $CupAndMenu/Container2/Cup/BobaCount
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var bobaCount: int = 0

#func _on_plus_pressed() -> void:
	#var boba
	#if (boba_pick.bobaNumber < 4):
		#boba = jelly.instantiate()
		#boba.find_child("Sprite").frame = boba_pick.bobaNumber
	#else:
		#boba = popping.instantiate()
		#boba.find_child("Sprite").frame = boba_pick.bobaNumber - 4
	#boba.rotation += randi() % 360
	#boba.position.x += randi() % 100 - 50
	#boba.position.y += randi() % 100 - 50
	#boba_spawn.add_child(boba)
	#bobaCount += 1
	#boba_count_label.text = str(bobaCount)
#
#
#func _on_minus_pressed() -> void:
	#var child = boba_spawn.get_child(boba_spawn.get_children().size()-1)
	#if(child != null):
		#boba_spawn.remove_child(child)
		#child.queue_free()
		#bobaCount -= 1
		#boba_count_label.text = str(bobaCount)


func _ready() -> void:
	animation_player.play("cup_drop")
