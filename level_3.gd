extends Node2D

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
	
	
	
	$Tutorial/TutorialScreen1/AnimatedSprite2D.play("default")
	$Tutorial/TutorialScreen2/AnimatedSprite2D.play("default")
	$Tutorial/TutorialScreen3/AnimatedSprite2D.play("default")
	$Tutorial/TutorialScreen4/AnimatedSprite2D.play("default")
	
	
	
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

func unlock():
	Save.game_data.player.keys.red = 1
	Save.save_data()
	$Player.keys.append("red")
	$CanvasLayer/GUI/Keys/AnimatedSprite2D2.play("filled")

func showHospitalLabel():
	$Hospital/Label.show()

func change_tutorial_screen_1_visibility():
	$CanvasLayer/Tutorials/Tutorial1.visible = !$CanvasLayer/Tutorials/Tutorial1.visible

func change_tutorial_screen_2_visibility():
	$CanvasLayer/Tutorials/Tutorial2.visible = !$CanvasLayer/Tutorials/Tutorial2.visible

func change_tutorial_screen_3_visibility():
	$CanvasLayer/Tutorials/Tutorial3.visible = !$CanvasLayer/Tutorials/Tutorial3.visible

func change_tutorial_screen_4_visibility():
	$CanvasLayer/Tutorials/Tutorial4.visible = !$CanvasLayer/Tutorials/Tutorial4.visible

func _on_area_2d_body_entered(body):
	if !$Player.isOnShip:
		$Door/Label.show()
		get_tree().get_first_node_in_group("Player").interactuableDoor = 0_3.0


func _on_area_2d_body_exited(body):
	$Door/Label.hide()
	get_tree().get_first_node_in_group("Player").interactuableDoor = 0


func _on_ship_area_2d_body_entered(body):
	if body.name == "Player":
		$Ship/Label.show()
		$Player.interactuableDoor = 1


func _on_ship_area_2d_body_exited(body):
	$Ship/Label.hide()
	$Player.interactuableDoor = 0


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


func _on_tutorial_screen_1_area_2d_body_entered(body):
	if body.name == "Player":
		$Player/InteractLabel.show()
		$Player.interactuableDoor = 100_0_3_1


func _on_tutorial_screen_1_area_2d_body_exited(body):
	$Player.interactuableDoor = 0
	$Player/InteractLabel.hide()
	$CanvasLayer/Tutorials/Tutorial1.hide()


func _on_tutorial_screen_2_area_2d_body_entered(body):
	if body.name == "Player":
		$Player/InteractLabel.show()
		$Player.interactuableDoor = 100_0_3_2


func _on_tutorial_screen_2_area_2d_body_exited(body):
	$Player.interactuableDoor = 0
	$Player/InteractLabel.hide()
	$CanvasLayer/Tutorials/Tutorial2.hide()


func _on_tutorial_screen_3_area_2d_body_entered(body):
	if body.name == "Player":
		$Player/InteractLabel.show()
		$Player.interactuableDoor = 100_0_3_3


func _on_tutorial_screen_3_area_2d_body_exited(body):
	$Player.interactuableDoor = 0
	$Player/InteractLabel.hide()
	$CanvasLayer/Tutorials/Tutorial3.hide()


func _on_tutorial_screen_4_area_2d_body_entered(body):
	if body.name == "Player":
		$Player/InteractLabel.show()
		$Player.interactuableDoor = 100_0_3_4


func _on_tutorial_screen_4_area_2d_body_exited(body):
	$Player.interactuableDoor = 0
	$Player/InteractLabel.hide()
	$CanvasLayer/Tutorials/Tutorial4.hide()
