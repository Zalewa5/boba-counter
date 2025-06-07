extends Node2D

const TITLE_BOBA = preload("res://Scenes/title_boba.tscn")

func spawn() -> void:
	var boba = TITLE_BOBA.instantiate()
	boba.position.x += randi() % 1800 + 60
	boba.find_child("Sprite").frame = randi() % 4
	add_child(boba)
	


func _on_timer_timeout() -> void:
	spawn()
