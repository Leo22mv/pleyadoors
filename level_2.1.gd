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
	
	for key in Save.game_data.world[1].collected_keys:
		for child in $Keys.get_children():
			if key == child.name:
				child.queue_free()
	
	$Player.keys.red = Save.game_data.player.keys.red
	$Player.keys.green = Save.game_data.player.keys.green
	$Player.keys.golden = Save.game_data.player.keys.golden
	
	
	$CanvasLayer/GUI.update_keys()
	
	if Save.game_data.player.unlockeddoors.find(2.2) != -1:
		$Keys/Key.queue_free()
		
	if Save.game_data.player.hp.max == 4:
		$CanvasLayer/GUI/Life/Heart4.show()

	$Tutorial/TutorialScreen1/AnimatedSprite2D.play("default")
	$Tutorial/TutorialScreen2/AnimatedSprite2D.play("default")
	
	for collected_gem in Save.game_data.world[1].collected_gems:
		for gem in $Gems.get_children():
			if gem.name == collected_gem:
				gem.queue_free()
	
	
	var color = Save.game_data.player.color
	var face = Save.game_data.player.face
	var spriteFrames = load("res://Assets/Player spritesheets/SpriteFrames/" + color + str(face) + ".tres")
	$Player/Node2D/AnimatedSprite2D.sprite_frames = spriteFrames
	
	
	
	

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

func unlock():
	Save.game_data.player.keys.red = 1
	Save.save_data()
	$Player.keys.append("red")
	$CanvasLayer/GUI/Keys/AnimatedSprite2D2.play("filled")

func change_tutorial_screen_1_visibility():
	$CanvasLayer/Tutorials/Tutorial1.visible = !$CanvasLayer/Tutorials/Tutorial1.visible
	
func change_tutorial_screen_2_visibility():
	$CanvasLayer/Tutorials/Tutorial2.visible = !$CanvasLayer/Tutorials/Tutorial2.visible


func _on_area_2d_body_entered(body):
		$Door/Label.show()
		get_tree().get_first_node_in_group("Player").interactuableDoor = 0_2.11


func _on_area_2d_body_exited(body):
	$Door/Label.hide()
	get_tree().get_first_node_in_group("Player").interactuableDoor = 0


func _on_tutorial_screen_1_area_2d_body_entered(body):
	if body.name == "Player":
		$Player/InteractLabel.show()
		$Player.interactuableDoor = 100_0_2.1_1


func _on_tutorial_screen_1_area_2d_body_exited(body):
	if body.name == "Player":
		$Player/InteractLabel.hide()
		$Player.interactuableDoor = 0
		$CanvasLayer/Tutorials/Tutorial1.hide()


func _on_tutorial_screen_2_area_2d_body_entered(body):
	if body.name == "Player":
		$Player/InteractLabel.show()
		$Player.interactuableDoor = 100_0_2.1_2


func _on_tutorial_screen_2_area_2d_body_exited(body):
	if body.name == "Player":
		$Player/InteractLabel.hide()
		$Player.interactuableDoor = 0
		$CanvasLayer/Tutorials/Tutorial2.hide()
