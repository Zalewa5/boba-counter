extends Control

func _on_resume_pressed() -> void:
	get_parent().pause()


func _on_main_menu_pressed() -> void:
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	Global.clear()


func _on_quit_pressed() -> void:
	get_tree().quit()
