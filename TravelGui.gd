extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	update_planet_1()
	$Planet1/AnimatedSprite2D.play("default")
	
	update_planet_2()
	$Planet2/AnimatedSprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	for child in get_parent().get_children():
#		if child.name == "Camera2D":
#			position = child.position
	
	offset = Vector2(960, 540)
	
#	pass

func update_planet_1():
	var collected_gems = 0
	for gem in Save.game_data.world[0].collected_gems:
		collected_gems += 1
	$Planet1/Sprite2D2/Label2.text = str(collected_gems) + "/10"
	$Planet1/Sprite2D2/Label2.position.x = -(($Planet1/Sprite2D2/Label2.size.x + 64) / 2)
	$Planet1/Sprite2D2/Label2/Sprite2D.position.x = $Planet1/Sprite2D2/Label2.size.x + 32
	collected_gems = null
	$Planet1/Sprite2D2/YouAreHereLabel.hide()
	$Planet1/Sprite2D2/TravelLabel.hide()
	if Save.game_data.actualworld.begins_with("level"):
		$Planet1/Sprite2D2/YouAreHereLabel.show()
	else:
		$Planet1/Sprite2D2/TravelLabel.show()

func update_planet_2():
#	var collected_gems = 10
#	for gem in Save.game_data.world[0].uncollected_gems:
#		collected_gems -= 1
#	$Planet1/Sprite2D2/Label2.text = str(collected_gems) + "/10"
	$Planet2/Sprite2D2/Label2.position.x = -(($Planet2/Sprite2D2/Label2.size.x + 64) / 2)
	$Planet2/Sprite2D2/Label2/Sprite2D.position.x = $Planet2/Sprite2D2/Label2.size.x + 32
#	collected_gems = null
	$Planet2/Sprite2D2/YouAreHereLabel.hide()
	$Planet2/Sprite2D2/TravelLabel.hide()
	if Save.game_data.actualworld.begins_with("world"):
		$Planet2/Sprite2D2/YouAreHereLabel.show()
	else:
		$Planet2/Sprite2D2/TravelLabel.show()
