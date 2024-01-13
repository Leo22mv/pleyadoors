extends Node2D

var door_1_locked = true
var door_2_locked = true
var door_3_locked = true

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	Save.load_data()
	
	$Player.curHp = Save.game_data.player.hp.cur
	get_tree().get_first_node_in_group("gui").update_health()
	
	$Player.curGems = Save.game_data.player.gems
	get_tree().get_first_node_in_group("gui").update_gems()
	
	$Player.position.x = Save.game_data.player.position.x
	$Player.position.y = Save.game_data.player.position.y
	
	if Save.game_data.player.isonship == true:
		get_tree().get_first_node_in_group("ship").get_child(1).disabled = true
		get_tree().get_first_node_in_group("ship").hide()
		$Player/Node2D/AnimatedSprite2D.play("ship")
		$Ship.position = $Player.position
		$Player.isOnShip = true
		$Player.set_collision_mask(2)
	else:
		$Ship.position.x = Save.game_data.ship.position.x
		$Ship.position.y = Save.game_data.ship.position.y
	
	if Save.game_data.player.hp.max == 4:
		$CanvasLayer/GUI/Life/Heart4.show()
		$CanvasLayer/GUI/Store/Item.queue_free()
		$CanvasLayer/GUI/Store/VoidStoreLabel.show()
		$CanvasLayer/GUI/Store.hide()
	
	
	
	$Player.keys.red = Save.game_data.player.keys.red
	$Player.keys.green = Save.game_data.player.keys.green
	$Player.keys.golden = Save.game_data.player.keys.golden
	
	
	
	$CanvasLayer/GUI.update_keys()
	
	
	
	$TravelGui/Sprite2D.position.x -= 1920
	$TravelGui/Planet1.position.x -= 1920
	$TravelGui/Planet2.position.x -= 1920
	$Player.travel_gui_focused_planet = 2
	
	
	
	for door in Save.game_data.player.unlockeddoors:
		match door:
			1_1:
				door_1_locked = false
				$Door/AnimatedSprite2D.play("opened")
				var color = $Door/Label/EnterLabel.get_modulate()
				$Door/Label/EnterLabel.set_modulate(Color(color.r, color.g, color.b, 255))
	
	for teleporter in Save.game_data.world[3].unlocked_teleporters:
		for child in $Teleporters.get_children():
			if child.name == teleporter:
				child.unlock()
	
	$Player/Node2D/PointLight2D.enabled = false
	$CanvasLayer/GUI/PointLight2D.enabled = false
	
	
	var color = Save.game_data.player.color
	var face = Save.game_data.player.face
	var spriteFrames = load("res://Assets/Player spritesheets/SpriteFrames/" + color + str(face) + ".tres")
	$Player/Node2D/AnimatedSprite2D.sprite_frames = spriteFrames
	
	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Camera2D.position.x = $Player/Node2D/Node2D.global_position.x
	if $Player.position.y < 540:
		$Camera2D.position.y = $Player/Node2D/Node2D.global_position.y
	else:
		$Camera2D.position.y = 540

func unlock_door_1():
	door_1_locked = false
	$Door/AnimatedSprite2D.play("opened")
	Save.game_data.player.unlockeddoors.append(1_1)
	Save.game_data.player.keys.golden -= 1
	Save.save_data()
	$Player.keys.golden -= 1
	$CanvasLayer/GUI.update_keys()
	var color = $Door/Label/EnterLabel.get_modulate()
	$Door/Label/EnterLabel.set_modulate(Color(color.r, color.g, color.b, 255))
	$Player/InteractLabel.hide()

func showHospitalLabel():
	$Hospital/Label.show()


func _on_area_2d_body_entered(body):
	if !$Player.isOnShip:
		$Player.interactuableDoor = 1_1
		$Door/Label.show()
		if door_1_locked:
			if $Player.keys.golden > 0:
				$Player/InteractLabel.show()


func _on_area_2d_body_exited(body):
	$Door/Label.hide()
	get_tree().get_first_node_in_group("Player").interactuableDoor = 0
	$Player/InteractLabel.hide()


func _on_store_area_2d_body_entered(body):
	if body.name == "Player":
		$Player/InteractLabel.show()
		$Player.interactuableDoor = 15


func _on_store_area_2d_body_exited(body):
	if body.name == "Player":
		$Player/InteractLabel.hide()
		$Player.interactuableDoor = 0


func _on_hospital_area_2d_body_entered(body):
	if body.name == "Player":
		$Player/InteractLabel.show()
		$Player.interactuableDoor = 911


func _on_hospital_area_2d_body_exited(body):
	if body.name == "Player":
		$Player/InteractLabel.hide()
		$Player.interactuableDoor = 0
		$Hospital/Label.hide()


func _on_door_2_area_body_entered(body):
	if !$Player.isOnShip:
		$Door2/Label.show()
		get_tree().get_first_node_in_group("Player").interactuableDoor = 1_2


func _on_door_2_area_body_exited(body):
	$Door2/Label.hide()
	get_tree().get_first_node_in_group("Player").interactuableDoor = 0

func _on_door_3_area_body_entered(body):
	if !$Player.isOnShip:
		$Door3/Label.show()
		get_tree().get_first_node_in_group("Player").interactuableDoor = 1_3


func _on_door_3_area_body_exited(body):
	$Door3/Label.hide()
	get_tree().get_first_node_in_group("Player").interactuableDoor = 0
