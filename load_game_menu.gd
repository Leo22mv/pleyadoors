extends Control

var actualSlotConfirming = 0

var buttons_updated = false



# Called when the node enters the scene tree for the first time.
func _ready():
	$Slot1Button/Label.set_modulate(Color.BLACK)
	$Slot1Button/Label2.set_modulate(Color.BLACK)
	$Slot2Button/Label.set_modulate(Color.BLACK)
	$Slot2Button/Label2.set_modulate(Color.BLACK)
	$Slot3Button/Label.set_modulate(Color.BLACK)
	$Slot3Button/Label2.set_modulate(Color.BLACK)
	update_buttons_info()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !buttons_updated:
		update_buttons_info()
#		pass

func load_game(slot):
	Save.actualSlot = slot
	Save.load_data()
	get_tree().change_scene_to_file("res://" + Save.game_data.actualworld + ".tscn")
	if get_parent().name == "Control":
		get_tree().paused = not get_tree().paused

func update_buttons_info():
	Save.actualSlot = 1
	if Save.verifyFileExistence():
		Save.load_data()
		$Slot1Button.texture_normal = preload("res://Assets/Buttons/filledSlot1.png")
		$Slot1Button.texture_pressed = preload("res://Assets/Buttons/filledSlot1Active.png")
		$Slot1Button.texture_hover = preload("res://Assets/Buttons/filledSlot1Hover.png")
		$Slot1Button/Label.text = str(Save.game_data.player.gems)
		$Slot1Button/Label.position.x = 745 - $Slot1Button/Label.size.x
		$Slot1Button/Label.show()
		$Slot1Button/Label2.position.x = 800 - $Slot1Button/Label2.size.x
		$Slot1Button/Label2.show()
	else:
		$Slot1Button.disabled = true

	Save.actualSlot = 2
	if Save.verifyFileExistence():
		Save.load_data()
		$Slot2Button.texture_normal = preload("res://Assets/Buttons/filledSlot2.png")
		$Slot2Button.texture_pressed = preload("res://Assets/Buttons/filledSlot2Active.png")
		$Slot2Button.texture_hover = preload("res://Assets/Buttons/filledSlot2Hover.png")
		$Slot2Button/Label.text = str(Save.game_data.player.gems)
		$Slot2Button/Label.position.x = 745 - $Slot2Button/Label.size.x
		$Slot2Button/Label.show()
		$Slot2Button/Label2.position.x = 800 - $Slot2Button/Label2.size.x
		$Slot2Button/Label2.show()
	else:
		$Slot2Button.disabled = true
		
	Save.actualSlot = 3
	if Save.verifyFileExistence():
		Save.load_data()
		$Slot3Button.texture_normal = preload("res://Assets/Buttons/filledSlot3.png")
		$Slot3Button.texture_pressed = preload("res://Assets/Buttons/filledSlot3Active.png")
		$Slot3Button.texture_hover = preload("res://Assets/Buttons/filledSlot3Hover.png")
		$Slot3Button/Label.text = str(Save.game_data.player.gems)
		$Slot3Button/Label.position.x = 745 - $Slot3Button/Label.size.x
		$Slot3Button/Label.show()
		$Slot3Button/Label2.position.x = 800 - $Slot3Button/Label2.size.x
		$Slot3Button/Label2.show()
	else:
		$Slot3Button.disabled = true
	
	Save.actualSlot = Save.actualSlotBackup

func show_popup():
	$Slot1Button.disabled = true
	$Slot2Button.disabled = true
	$Slot3Button.disabled = true
	$ConfirmLoadPopup.show()

func hide_popup():
	$ConfirmLoadPopup.hide()
	$Slot1Button.disabled = false
	$Slot2Button.disabled = false
	$Slot3Button.disabled = false

func _on_slot_1_button_button_up():
	actualSlotConfirming = 1
	if get_parent().name == "Control":
		show_popup()
	else:
		_on_confirm_load_button_button_up()


func _on_slot_2_button_button_up():
	actualSlotConfirming = 2
	if get_parent().name == "Control":
		show_popup()
	else:
		_on_confirm_load_button_button_up()


func _on_slot_3_button_button_up():
	actualSlotConfirming = 3
	if get_parent().name == "Control":
		show_popup()
	else:
		_on_confirm_load_button_button_up()


func _on_return_button_button_up():
	if get_parent().name == "Control":
		for child in get_parent().get_children():
			if child.name == "LoadGameMenu":
				child.hide()
				get_parent().get_parent().hide_popup()
				get_parent().get_parent().show_buttons()
				get_tree().get_first_node_in_group("gui").show()
	else:
		get_tree().change_scene_to_file("res://MainMenu.tscn")
			

func _on_slot_1_button_mouse_entered():
	$Slot1Button/Label.set_modulate(Color.WHITE)
	$Slot1Button/Label2.set_modulate(Color.WHITE)


func _on_slot_1_button_mouse_exited():
	$Slot1Button/Label.set_modulate(Color.BLACK)
	$Slot1Button/Label2.set_modulate(Color.BLACK)


func _on_slot_2_button_mouse_entered():
	$Slot2Button/Label.set_modulate(Color.WHITE)
	$Slot2Button/Label2.set_modulate(Color.WHITE)


func _on_slot_2_button_mouse_exited():
	$Slot2Button/Label.set_modulate(Color.BLACK)
	$Slot2Button/Label2.set_modulate(Color.BLACK)


func _on_slot_3_button_mouse_entered():
	$Slot3Button/Label.set_modulate(Color.WHITE)
	$Slot3Button/Label2.set_modulate(Color.WHITE)


func _on_slot_3_button_mouse_exited():
	$Slot3Button/Label.set_modulate(Color.BLACK)
	$Slot3Button/Label2.set_modulate(Color.BLACK)


func _on_confirm_load_button_button_up():
	match actualSlotConfirming:
		1:
			Save.actualSlotBackup = 1
			load_game(1)
		
		2:
			Save.actualSlotBackup = 2
			load_game(2)
		
		3:
			Save.actualSlotBackup = 3
			load_game(3)
		
	actualSlotConfirming = 0


func _on_no_confirm_load_button_button_up():
	hide_popup()
	actualSlotConfirming = 0
