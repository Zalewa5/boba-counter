extends Node2D

var direction: bool = true
const SPEED: int = 200

func _physics_process(delta: float) -> void:
	position.y += delta * SPEED
	if (randi() % 50) == 0:
		direction = !direction
	if direction:
		position.x += delta * SPEED
	else:
		position.x -= delta * SPEED
	

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
