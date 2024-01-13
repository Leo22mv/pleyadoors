extends Node2D

var locked = true

var locked1 = true

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
	
#	for gem in $Gems.get_children():
#		if gem.name == "BlueGems":
#			for child in gem.get_children():
#				var withoutcoincidence = true
#				for uncollectedGem in Save.game_data.world[0].uncollected_gems:
#					if uncollectedGem == child.name:
#						withoutcoincidence = false
#
#				if withoutcoincidence:
#					child.queue_free()
#		else:
#			var withoutcoincidence = true
#			for uncollectedGem in Save.game_data.world[0].uncollected_gems:
#	#			print(uncollectedGem + "!=" + gem.name)
#
#
#				if uncollectedGem == gem.name:
#					withoutcoincidence = false
#
#			if withoutcoincidence:
#					gem.queue_free()
#	#				pass
	
	for collected_gem in Save.game_data.world[0].collected_gems:
		for gem in $Gems.get_children():
			if gem.name == "BlueGems":
				for children in gem.get_children():
					if children.name == collected_gem:
						gem.queue_free()
			else:
				if gem.name == collected_gem:
					gem.queue_free()
	
	if Save.game_data.world[0].collected_keys.size() == 1:
		$Keys/Key.queue_free()
	
	$Player.keys.red = Save.game_data.player.keys.red
	$Player.keys.green = Save.game_data.player.keys.green
	$Player.keys.golden = Save.game_data.player.keys.golden
	
	
	$CanvasLayer/GUI.update_keys()
	
	for door in Save.game_data.player.unlockeddoors:
		match door:
			2.1:
				locked1 = false
				$Door2/AnimatedSprite2D.play("opened")
			
			2.2:
				locked = false
				$RedDoor/AnimatedSprite2D.play("opened")
	
	Save.game_data.actualworld = "level_2"
	Save.save_data()
	
	if Save.game_data.player.hp.max == 4:
		$CanvasLayer/GUI/Life/Heart4.show()
		for gem in $Gems.get_children():
			gem.queue_free()
		
		
	$Tutorial/TutorialScreen1/AnimatedSprite2D.play("default")
	$Tutorial/TutorialScreen2/AnimatedSprite2D.play("default")
	
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
	if $Player.position.x >= 960 and $Player.position.x <= 8000:
		$Camera2D.position.x = $Player/Node2D/Node2D.global_position.x
	elif $Player.position.x < 960:
		$Camera2D.position.x = 960
	
	if $Player.position.y >= 790:
		$Camera2D.position.y = $Player/Node2D/Node2D.global_position.y - 244
	else:
		$Camera2D.position.y = 540
	
	$Tutorial/PointLight2D.position = $Camera2D.position

func unlock():
	locked = false
	$RedDoor/AnimatedSprite2D.play("opened")
	$RedDoor/UnlockLabel.hide()
	$RedDoor/EnterLabel.show()
	Save.game_data.player.unlockeddoors.append(2.2)
	Save.game_data.player.keys.red = 0
	Save.save_data()
	$Player.keys.red -= 1
	$CanvasLayer/GUI.update_keys()


func _on_area_2d_body_entered(body):
	if locked:
		if $Player.keys.red > 0:
			$RedDoor/UnlockLabel.show()
			get_tree().get_first_node_in_group("Player").interactuableDoor = 0_2.2
	else:
		$RedDoor/EnterLabel.show()
		get_tree().get_first_node_in_group("Player").interactuableDoor = 0_2.2
		get_tree().get_first_node_in_group("Player").interactuableDoor2 = 0_2.2

func win():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://win_screen.tscn")


func _on_area_2d_body_exited(body):
	$RedDoor/EnterLabel.hide()
	$RedDoor/UnlockLabel.hide()
	get_tree().get_first_node_in_group("Player").interactuableDoor = 0
	get_tree().get_first_node_in_group("Player").interactuableDoor2 = 0


func _on_area_2d_body_entered2(body):
	$Door/EnterLabel.show()
	get_tree().get_first_node_in_group("Player").interactuableDoor = 0_2.0


func _on_area_2d_body_exited2(body):
	$Door/EnterLabel.hide()
	get_tree().get_first_node_in_group("Player").interactuableDoor = 0


func _on_area_2d_body_entered3(body):
	if locked1:
		if $Player.keys.green > 0:
			$Door2/UnlockLabel.show()
			get_tree().get_first_node_in_group("Player").interactuableDoor = 0_2.1
	else:
		$Door2/EnterLabel.show()
		$Player.interactuableDoor = 0_2.1
		$Player.interactuableDoor2 = 0_2.1


func _on_area_2d_body_exited3(body):
	$Door2/EnterLabel.hide()
	$Door2/UnlockLabel.hide()
	get_tree().get_first_node_in_group("Player").interactuableDoor = 0
	$Player.interactuableDoor2 = 0


func returnToLastLevel():
	Save.game_data.player.position.x = 4192
	Save.game_data.player.position.y = 320
	Save.game_data.actualworldcoords = [288, 768]
	Save.game_data.actualworld = "level_1"
#	Save.game_data.world[0].uncollected_gems.clear()
#	for gem in get_tree().get_first_node_in_group("gems2").get_children():
#		Save.game_data.world[0].uncollected_gems.append(gem.name)
	Save.save_data()
#	print(Save.game_data.player.position.x)
	get_tree().change_scene_to_file("res://level_1.tscn")

func enter1():
	Save.game_data.player.position.x = 96
	Save.game_data.player.position.y = 640
	Save.game_data.actualworldcoords = [96, 640]
	Save.game_data.actualworld = "level_2.1"
#	Save.game_data.world[0].uncollected_gems.clear()
#	for gem in get_tree().get_first_node_in_group("gems2").get_children():
#		Save.game_data.world[0].uncollected_gems.append(gem.name)
	Save.save_data()
	get_tree().change_scene_to_file("res://level_2.1.tscn")

func unlock1():
	locked1 = false
	$Door2/AnimatedSprite2D.play("opened")
	$Door2/UnlockLabel.hide()
	$Door2/EnterLabel.show()
	Save.game_data.player.unlockeddoors.append(2.1)
	Save.game_data.player.keys.green = 0
	Save.save_data()
	$Player.keys.green -= 1
	$CanvasLayer/GUI.update_keys()
	

func change_tutorial_screen_1_visibility():
	$CanvasLayer/Tutorials/Tutorial1.visible = !$CanvasLayer/Tutorials/Tutorial1.visible

func change_tutorial_screen_2_visibility():
	$CanvasLayer/Tutorials/Tutorial2.visible = !$CanvasLayer/Tutorials/Tutorial2.visible


func _on_tutorial_screen_1_area_2d_body_entered(body):
	if body.name == "Player":
		$Player/InteractLabel.show()
		$Player.interactuableDoor = 100_0_2.1


func _on_tutorial_screen_1_area_2d_body_exited(body):
	$Player.interactuableDoor = 0
	$Player/InteractLabel.hide()
	$CanvasLayer/Tutorials/Tutorial1.hide()


func _on_tutorial_screen_2_area_2d_body_entered(body):
	if body.name == "Player":
		$Player/InteractLabel.show()
		$Player.interactuableDoor = 100_0_2.2


func _on_tutorial_screen_2_area_2d_body_exited(body):
	$Player.interactuableDoor = 0
	$Player/InteractLabel.hide()
	$CanvasLayer/Tutorials/Tutorial2.hide()
