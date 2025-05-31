extends TextureRect

@onready var button: TextureButton = $"../Next"
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var message: set = set_message

func set_message(new_message):
	message = new_message
	$Message.text = new_message

func open():
	animation_player.play("typewriter")
	self.visible = true
	button.disabled = true

func close():
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "typewriter":
		button.disabled = false
