extends Control

var actualSlotConfirming = 0

var isSlot1Empty = true
var isSlot2Empty = true
var isSlot3Empty = true

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
#	pass

func newGame():
#	Save.load_actual_slot()
#	Save.game_data.player.position.x = 288
#	Save.game_data.player.position.y = 768
#	Save.game_data.player.hp.cur = 3
#	Save.game_data.player.hp.max = 3
#	Save.game_data.player.gems = 0
#	Save.game_data.player.keys.red = 0
#	Save.game_data.player.keys.green = 0
#	Save.game_data.player.keys.golden = 0
#	Save.game_data.player.unlockeddoors.clear()
#	Save.game_data.player.isonship = false
#	Save.game_data.world[0].uncollected_gems = ["Gem", "Gem2", "Gem3", "Gem4", "Gem5", "Gem6", "Gem7", "Gem8", "Gem9", "Gem10"]
#	for world in Save.game_data.world:
#		world.collected_keys.clear()
#		if world.name == "world_1.1":
#			world.collected_gems.clear()
#		if world.name == "world_1":
#			world.unlocked_teleporters.clear()
#	Save.game_data.actualworld = "level_1"
#	Save.game_data.actualworldcoords = [288, 768]
#	Save.game_data.ship.position.x = 7456
#	Save.game_data.ship.position.y = 760
	Save.game_data = Save.empty_game_data
	Save.save_data()
	get_tree().change_scene_to_file("res://customize_player_screen.tscn")
	

func show_popup():
	$Slot1Button.disabled = true
	$Slot2Button.disabled = true
	$Slot3Button.disabled = true
	$ConfirmOverwritePopup.show()

func hide_popup():
	$ConfirmOverwritePopup.hide()
	$Slot1Button.disabled = false
	$Slot2Button.disabled = false
	$Slot3Button.disabled = false

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
		isSlot1Empty = false
		
	
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
		isSlot2Empty = false
		
		
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
		isSlot3Empty = false
		
	
	Save.actualSlot = Save.actualSlotBackup

func _on_return_button_button_up():
	get_tree().change_scene_to_file("res://MainMenu.tscn")


func _on_slot_1_button_button_up():
	actualSlotConfirming = 1
	if isSlot1Empty:
		_on_confirm_overwrite_button_button_up()
	else:
		show_popup()
	


func _on_slot_2_button_button_up():
	actualSlotConfirming = 2
	if isSlot2Empty:
		_on_confirm_overwrite_button_button_up()
	else:
		show_popup()


func _on_slot_3_button_button_up():
	actualSlotConfirming = 3
	if isSlot3Empty:
		_on_confirm_overwrite_button_button_up()
	else:
		show_popup()


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


func _on_confirm_overwrite_button_button_up():
	Save.actualSlot = actualSlotConfirming
	Save.actualSlotBackup = actualSlotConfirming
	Save.save_data()
	newGame()


func _on_no_confirm_overwrite_button_button_up():
	hide_popup()
	actualSlotConfirming = 0
