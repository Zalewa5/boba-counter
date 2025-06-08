extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var dialog_bubble: AnimatedSprite2D = $DialogBubble
@onready var tea_menu: Sprite2D = $TeaMenu
@onready var next: BaseButton = $Next
@onready var another_drink: AnimatedSprite2D = $AnotherDrink
@onready var name_prompt: AnimatedSprite2D = $NamePrompt
@onready var line_edit: LineEdit = $NamePrompt/LineEdit
@onready var boba_menu: Sprite2D = $BobaMenu
@onready var cup_sizes: AnimatedSprite2D = $CupSizes
@onready var conv: Label = $DialogBubble/Message
@onready var yapper: AnimatedSprite2D = $Yapper
@onready var pause_menu: Control = $PauseMenu

@export var scene: PackedScene


enum CupStatus {NOT, MAX}
var cup_status = CupStatus.NOT
var dialog_state: int = 0
var cup_count = Global.cups_count
var rng_answer: int = 0
var cup_size: int = -1 # 0 - small; 1 - medium; 2 - large; 3 - infinicup
var boba_type_size: int
var customer_name: String
var paused: bool = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pause()

func pause():
	if paused:
		pause_menu.hide()
	else:
		pause_menu.show()
	paused = !paused


func _ready() -> void:
	animation_player.play("Yap")

func dialog():
	match cup_status:
		CupStatus.NOT:
			match dialog_state:
				0:
					# Message appears only on the first enter to boba shop
					dialog_state = 1
					dialog_bubble.message = "Hello, welcome to Boba Blasters!"
					dialog_bubble.open()
				1:
					# Loop starts here, pick tea flavor
					conv.add_theme_font_size_override("font_size", 64)
					cup_count += 1
					Global.cups_count = cup_count
					dialog_bubble.message = "What would you like to order?"
					animation_player.play("TeaMenu")
					dialog_bubble.open()
					dialog_state = 2
				2:
					# If tea isn't picked tells to pick again, else gives random answer, adds tea taste to table, resets for tea taste for future
					if tea_menu.tea == -1:
						dialog_bubble.message = "Try again!"
						dialog_state = 2
					else:
						rng_answer = randi() % 4
						match rng_answer:
							0:
								dialog_bubble.message = "Amazing choice, I see someone has good taste!"
							1:
								dialog_bubble.message = "Nice, this one is SO refreshing after a long day at work"
							2:
								dialog_bubble.message = "Oooo, interesting choice. I'd pick that too."
							3:
								dialog_bubble.message = "I gotta warn you, this flavour is kinda addicting"
						dialog_state = 3
						Global.tea.append(tea_menu.tea)
						tea_menu.tea = -1
						animation_player.play("ByeTea")
						tea_menu.clean()
					dialog_bubble.open()
				3:
					# Shows drink size buttons
					cup_sizes.visible = true
					$CupSizes/Small.disabled = true
					$CupSizes/Medium.disabled = true
					$CupSizes/Large.disabled = true
					$"CupSizes/Infini-cup".disabled = true
					dialog_state = 4
					dialog_bubble.message = "How large do you want the drink to be?"
					next.visible = false
					dialog_bubble.open()
				4:
					# Sets answer depending on drink & adds size to table
					match cup_sizes.cup_size:
						0:
							conv.add_theme_font_size_override("font_size", 60)
							dialog_bubble.message = "Not that thirsty huh? Well it's nice to get a sweet treat once in a while isn't it?"
						1:
							dialog_bubble.message = "Awesome"
						2:
							dialog_bubble.message = "Big treat for big thirsty I see"
						3:
							dialog_bubble.message = "With infinicup, the whole cafe is your cup, enjoy!"
					Global.cup_size.append(cup_sizes.cup_size)
					cup_sizes.cup_size = -1
					dialog_state = 5
					dialog_bubble.open()
				5:
					# Get boba menu & pick boba type
					dialog_state = 6
					conv.add_theme_font_size_override("font_size", 64)
					dialog_bubble.message = "What kind of boba or jelly would you like?"
					animation_player.play("BobaMenu")
					dialog_bubble.open()
				6:
					# If no boba picked, try again, else adds boba type & taste to tables and gets rid of boba menu
					boba_type_size = boba_menu.boba_type.size()
					if boba_type_size == 0:
						dialog_bubble.message = "Try again!"
						dialog_state = 6
					else:
						if boba_type_size == 1:
							rng_answer = randi() % 3
							match rng_answer:
								0:
									dialog_bubble.message = "Nothing beats a classic choice."
								1:
									dialog_bubble.message = "Keeping it simple I see? Gotta respect that."
								2:
									dialog_bubble.message = "You can always add more pearls next time, no pressure though!"
						elif boba_type_size > 1 && boba_type_size < 6:
							rng_answer = randi() % 3
							match rng_answer:
								0:
									dialog_bubble.message = "Interesting mix you got there, bet it tastes funky"
								1:
									dialog_bubble.message = "Good choices, honestly need to try those myself!"
								2:
									conv.add_theme_font_size_override("font_size", 56)
									dialog_bubble.message = "Huh, didn't know this combo even existed, but by the looks of it this will taste interesting"
						elif boba_type_size >=6 && boba_type_size < 11:
							rng_answer = randi() % 3
							match rng_answer:
								0:
									dialog_bubble.message = "Um, okay, whatever gives you happiness"
								1:
									dialog_bubble.message = "Are you sure you want THAT much variety? Yeah? Okay."
								2:
									dialog_bubble.message = "No matter what you put here, the price will stay the same!"
						else:
							rng_answer = randi() % 3
							match rng_answer:
								0:
									conv.add_theme_font_size_override("font_size", 40)
									dialog_bubble.message = "the boba shop policy states that the shop is not responsible for this product, and that the person making this order has willingly agreed to choose this option without the interferance of the boba staff."
								1:
									dialog_bubble.message = "Wow, okay, um, should I look up poison control before I make you this?"
						dialog_state = 7
						Global.boba_type.append(boba_menu.boba_type)
						Global.boba_taste.append(boba_menu.boba_taste)
						boba_menu.boba_type = Array([], TYPE_INT, "", null)
						boba_menu.boba_taste = Array([], TYPE_INT, "", null)
						animation_player.play("ByeBoba")
						boba_menu.clean()
					dialog_bubble.open()
				7:
					# Show name prompt
					conv.add_theme_font_size_override("font_size", 64)
					dialog_state = 8
					dialog_bubble.message = "Alright, who will this be for?"
					name_prompt.visible = true
					dialog_bubble.open()
				8:
					# Saves name to table
					customer_name = line_edit.text
					if customer_name.length() == 0:
						conv.add_theme_font_size_override("font_size", 56)
						dialog_bubble.message = "Choosing to stay anonymous. huh? That's fair, I don't trust the government either."
						line_edit.text = " "
					else:
						if customer_name.length() < 10:
							rng_answer = randi() % 2
							match rng_answer:
								0:
									dialog_bubble.message = "Sweet."
								1:
									dialog_bubble.message = "Awesome."
						else:
							rng_answer = randi() % 2
							match rng_answer:
								0:
									dialog_bubble.message = "Wow, a bit of a long one huh, I hope I can spell it correctly"
								1:
									dialog_bubble.message = "... Do you maybe have any nicknames?"
					name_prompt.visible = false
					Global.cup_name.append(line_edit.text)
					line_edit.text = ""
					dialog_state = 9
					dialog_bubble.open()
				9:
					# If already at 4 cups force to end else give option to get another cup
					dialog_state = 1
					conv.add_theme_font_size_override("font_size", 64)
					if cup_count >= 4:
						cup_status = CupStatus.MAX
						conv.add_theme_font_size_override("font_size", 44)
						dialog_bubble.message = "We're trying to prevent these so called \"boba scalpers\" that are going around nowadays, so we have to limit your drinks to 4. Sorry, store policy."
						dialog_bubble.open()
					else:
						dialog_bubble.visible = false
						next.visible = false
						another_drink.visible = true
		CupStatus.MAX:
			match dialog_state:
				1:
					dialog_state = 2
					if cup_count > 1:
						dialog_bubble.message = "Awesome! Enjoy your drinks!"
					else:
						dialog_bubble.message = "Awesome! Enjoy your drink!"
					dialog_bubble.open()
				2:
					next.visible = false
					dialog_bubble.visible = false
					animation_player.play("YapBye")

func _on_next_pressed() -> void:
	dialog()


func _on_yes_pressed() -> void:
	another_drink.visible = false
	next.visible = true
	dialog_bubble.visible = true
	dialog()


func _on_no_pressed() -> void:
	cup_status = CupStatus.MAX
	another_drink.visible = false
	next.visible = true
	dialog_bubble.visible = true
	dialog()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Yap":
		dialog_bubble.visible = true
		next.visible = true
		dialog()
	if anim_name == "YapBye":
		get_tree().change_scene_to_packed(scene)
