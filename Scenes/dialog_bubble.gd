extends TextureRect

@onready var button: BaseButton = $"../Next"
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var message: set = set_message

func set_message(new_message):
	message = new_message
	$Message.text = new_message

func open():
	get_parent().yapper.animation = "yap"
	animation_player.play("typewriter")
	self.visible = true
	button.disabled = true

func close():
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "typewriter":
		button.disabled = false
		get_parent().find_child("CupSizes").find_child("Small").disabled = false
		get_parent().find_child("CupSizes").find_child("Medium").disabled = false
		get_parent().find_child("CupSizes").find_child("Large").disabled = false
		get_parent().find_child("CupSizes").find_child("Infini-cup").disabled = false
		get_parent().yapper.animation = "default"
