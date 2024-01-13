extends Node2D

var locked = true

var closed = true

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
#	Save.load_actual_slot()
	Save.load_data()
#	print(Save.actualSlot)
	
	$Player.curHp = Save.game_data.player.hp.cur
	get_tree().get_first_node_in_group("gui").update_health()
	
	$Player.curGems = Save.game_data.player.gems
	get_tree().get_first_node_in_group("gui").update_gems()
	
	$Player.position.x = Save.game_data.player.position.x
	$Player.position.y = Save.game_data.player.position.y
	
#	print(Save.game_data.player.position.x)
	
	for door in Save.game_data.player.unlockeddoors:
		if door == 1.1:
			locked = false
			$Door/AnimatedSprite2D.play("opened")
	
	if Save.game_data.world[2].collected_keys.size() == 1:
		$Keys/Key.queue_free()
	
	$Player.keys.red = Save.game_data.player.keys.red
	$Player.keys.green = Save.game_data.player.keys.green
	$Player.keys.golden = Save.game_data.player.keys.golden
	
	
	$CanvasLayer/GUI.update_keys()
	
	if Save.game_data.player.hp.max == 4:
		$CanvasLayer/GUI/Life/Heart4.show()
	
	
	$Tutorial/TutorialScreen1/AnimatedSprite2D.play("default")
	$Tutorial/TutorialScreen2/AnimatedSprite2D.play("default")
	$Tutorial/TutorialScreen3/AnimatedSprite2D.play("default")
	
	
	var color = Save.game_data.player.color
	var face = Save.game_data.player.face
	var spriteFrames = load("res://Assets/Player spritesheets/SpriteFrames/" + color + str(face) + ".tres")
	$Player/Node2D/AnimatedSprite2D.sprite_frames = spriteFrames
	
	
	
	for world in Save.game_data.world:
		if world.node_name == name:
			for destroyed_wall in world.destroyed_walls:
				for destroyable_wall in $DestroyableWalls.get_children():
					if destroyed_wall == destroyable_wall.name:
						destroyable_wall.queue_free()
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	print($Player.position.x)
	if !$Camera2D.shaking:
		if $Player.position.x >= 960 and $Player.position.x <= 10606:
			$Camera2D.position.x = $Player/Node2D/Node2D.global_position.x
		
		if $Player.position.y >= 790:
			$Camera2D.position.y = $Player/Node2D/Node2D.global_position.y - 244
		else:
			$Camera2D.position.y = 540
		
		if $Player.position.x <= 960:
			$Camera2D.position.x = 960
		elif $Player.position.x >= 10606:
			$Camera2D.position.x = 10616
	
	$Tutorial/PointLight2D.position = $Camera2D.position
#	$Tutorial/Tutorial2.position.x = $Camera2D.position.x - 960
#	$Tutorial/Tutorial3.position = $Camera2D.position - Vector2(960, 540)

func unlock():
	locked = false
	$Door/AnimatedSprite2D.play("opened")
	$Door/UnlockLabel.hide()
	$Door/EnterLabel.show()
	Save.game_data.player.unlockeddoors.append(1.1)
	Save.game_data.player.keys.red = 0
	Save.save_data()
	$Player.keys.red -= 1
	$CanvasLayer/GUI.update_keys()


func _on_area_2d_body_entered(body):
	if locked:
		if $Player.keys.red > 0:
			$Door/UnlockLabel.show()
			get_tree().get_first_node_in_group("Player").interactuableDoor = 0_1.1
	else:
		$Door/EnterLabel.show()
		get_tree().get_first_node_in_group("Player").interactuableDoor = 0_1.1
		get_tree().get_first_node_in_group("Player").interactuableDoor2 = 0_1.1

func win():
	Save.game_data.player.hp.cur = $Player.curHp
	Save.game_data.player.position.x = 96
	Save.game_data.player.position.y = 128
	Save.game_data.actualworldcoords = [96, 128]
	Save.save_data()
	get_tree().change_scene_to_file("res://level_2.tscn")

func change_tutorial_screen_1_visibility():
	$CanvasLayer/Tutorials/Tutorial1.visible = !$CanvasLayer/Tutorials/Tutorial1.visible

func change_tutorial_screen_2_visibility():
	$CanvasLayer/Tutorials/Tutorial2.visible = !$CanvasLayer/Tutorials/Tutorial2.visible

func change_tutorial_screen_3_visibility():
	$CanvasLayer/Tutorials/Tutorial3.visible = !$CanvasLayer/Tutorials/Tutorial3.visible

func change_tutorial_screen_4_visibility():
	$CanvasLayer/Tutorials/Tutorial4.visible = !$CanvasLayer/Tutorials/Tutorial4.visible

func _on_area_2d_body_exited(body):
	$Door/UnlockLabel.hide()
	$Door/EnterLabel.hide()
	get_tree().get_first_node_in_group("Player").interactuableDoor = 0
	get_tree().get_first_node_in_group("Player").interactuableDoor2 = 0


func _on_tutorial_screen_1_area_2d_body_entered(body):
	if body.name == "Player":
		if !$Player.newGame:
			$Player/InteractLabel.show()
		$Player.interactuableDoor = 100_1


func _on_tutorial_screen_1_area_2d_body_exited(body):
	$Player.interactuableDoor = 0
	$Player/InteractLabel.hide()
	$CanvasLayer/Tutorials/Tutorial1.hide()


func _on_tutorial_screen_2_area_2d_body_entered(body):
	if body.name == "Player":
		$Player/InteractLabel.show()
		$Player.interactuableDoor = 100_2


func _on_tutorial_screen_2_area_2d_body_exited(body):
	$Player.interactuableDoor = 0
	$Player/InteractLabel.hide()
	$CanvasLayer/Tutorials/Tutorial2.hide()


func _on_tutorial_screen_3_area_2d_body_entered(body):
	if body.name == "Player":
		$Player/InteractLabel.show()
		$Player.interactuableDoor = 100_3


func _on_tutorial_screen_3_area_2d_body_exited(body):
	$Player.interactuableDoor = 0
	$Player/InteractLabel.hide()
	$CanvasLayer/Tutorials/Tutorial3.hide()


func _on_tutorial_screen_4_area_2d_body_entered(body):
	if body.name == "Player":
		$Player/InteractLabel.show()
		$Player.interactuableDoor = 100_4


func _on_tutorial_screen_4_area_2d_body_exited(body):
	$Player.interactuableDoor = 0
	$Player/InteractLabel.hide()
	$CanvasLayer/Tutorials/Tutorial4.hide()
