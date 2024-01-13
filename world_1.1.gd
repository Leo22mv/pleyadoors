extends Node2D

var door_1_locked = true
var door_2_locked = true

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
	
	
	
	if Save.game_data.player.hp.max == 4:
		$CanvasLayer/GUI/Life/Heart4.show()
		$CanvasLayer/GUI/Store/Item.queue_free()
		$CanvasLayer/GUI/Store/VoidStoreLabel.show()
		$CanvasLayer/GUI/Store.hide()
	
	
	
	$Player.keys.red = Save.game_data.player.keys.red
	$Player.keys.green = Save.game_data.player.keys.green
	$Player.keys.golden = Save.game_data.player.keys.golden
	$CanvasLayer/GUI.update_keys()
	
	
	
	$Enemies/IdleEnemies/SpinnerEnemy7/Area2D.queue_free()
	$Enemies/IdleEnemies/SpinnerEnemy8/Area2D2.queue_free()
	$Enemies/IdleEnemies/SpinnerEnemy21/Area2D.queue_free()
	$Enemies/IdleEnemies/SpinnerEnemy22/Area2D2.queue_free()
	$Enemies/IdleEnemies/SpinnerEnemy58/Area2D.queue_free()
	$Enemies/IdleEnemies/SpinnerEnemy73/Area2D.queue_free()
	
	$Tutorial/TutorialScreen1/AnimatedSprite2D.play("default")
	
	
	
	for door in Save.game_data.player.unlockeddoors:
		match door:
			1_1_1:
				door_1_locked = false
				$Door1/AnimatedSprite2D.play("opened")
			
			1_1_2:
				door_2_locked = false
				$Door2/AnimatedSprite2D.play("opened")
	
	
	
	for collected_gem in Save.game_data.world[4].collected_gems:
		for children in $Gems.get_children():
			if children.name == collected_gem:
				children.queue_free()
			for gem in children.get_children():
				if gem.name == collected_gem:
					gem.queue_free()
	
	
	for collected_key in Save.game_data.world[4].collected_keys:
		for child in get_children():
			if child.name == "Keys":
				for key in child.get_children():
					if key.name == collected_key:
						key.queue_free()
	
	
	var color = Save.game_data.player.color
	var face = Save.game_data.player.face
	var spriteFrames = load("res://Assets/Player spritesheets/SpriteFrames/" + color + str(face) + ".tres")
	$Player/Node2D/AnimatedSprite2D.sprite_frames = spriteFrames
	
	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Player.position.x < 960 && $Player.position.y <= 800:
		$Camera2D.position.x = 960
#		$Camera2D.position.x = $Player/Node2D/Node2D.global_position.x
	else:
		$Camera2D.position.x = $Player/Node2D/Node2D.global_position.x
	
	$Camera2D.position.y = $Player/Node2D/Node2D.global_position.y
	
#	if $Player.position.y < 540 || ($Player.position.x >= 5824 && $Player.position.y >= 800):
#		$Camera2D.position.y = $Player.position.y
#
	if $Player.position.y > 540 && $Player.position.x < 5824 && $Player.position.y <= 800:
		$Camera2D.position.y = 540

func unlock_door_1():
	door_1_locked = false
	$Door1/AnimatedSprite2D.play("opened")
	Save.game_data.player.unlockeddoors.append(1_1_1)
	Save.game_data.player.keys.green -= 1
	Save.save_data()
	$Player.keys.green -= 1
	$CanvasLayer/GUI.update_keys()

func unlock_door_2():
	door_2_locked = false
	$Door2/AnimatedSprite2D.play("opened")
	Save.game_data.player.unlockeddoors.append(1_1_2)
	Save.game_data.player.keys.green -= 1
	Save.save_data()
	$Player.keys.green -= 1
	$CanvasLayer/GUI.update_keys()

func change_tutorial_screen_1_visibility():
	$CanvasLayer/Tutorials/Tutorial1.visible = !$CanvasLayer/Tutorials/Tutorial1.visible


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.show_interact_label()
		body.interactuableDoor = 1_1_0


func _on_area_2d_body_exited(body):
	get_tree().get_first_node_in_group("Player").interactuableDoor = 0
	$Player/InteractLabel.hide()

func _on_tutorial_screen_1_area_2d_body_entered(body):
	if body.name == "Player":
		$Player/InteractLabel.show()
		$Player.interactuableDoor = 100_1_1_1


func _on_tutorial_screen_1_area_2d_body_exited(body):
	$Player.interactuableDoor = 0
	$Player/InteractLabel.hide()
	$CanvasLayer/Tutorials/Tutorial1.hide()


func _on_door_1_area_body_entered(body):
	if door_1_locked:
		if $Player.keys.green > 0:
			$Player.show_interact_label()
			$Player.interactuableDoor = 1_1_1
			$Player.interactuableDoor2 = 1_1_1
	else:
		$Player.show_interact_label()
		$Player.interactuableDoor = 1_1_1
		$Player.interactuableDoor2 = 1_1_1


func _on_door_1_area_body_exited(body):
	$Player.hide_interact_label()
	$Player.interactuableDoor = 0
	$Player.interactuableDoor2 = 0


func _on_door_2_area_body_entered(body):
	if door_2_locked:
		if $Player.keys.green > 0:
			$Player.show_interact_label()
			$Player.interactuableDoor = 1_1_2
	else:
		$Player.show_interact_label()
		$Player.interactuableDoor = 1_1_2


func _on_door_2_area_body_exited(body):
	$Player.hide_interact_label()
	$Player.interactuableDoor = 0
