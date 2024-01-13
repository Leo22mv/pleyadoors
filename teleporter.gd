extends Node2D

var unlocked = false


# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent().name == "World1_1":
		unlocked = true
		
	if unlocked:
		$AnimatedSprite2D.play("active")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_teleporter_area_2d_body_entered(body):
	if body.name == "Player":
		if unlocked:
			body.show_interact_label()
			match Save.game_data.actualworld:
				"world_1":
					match name:
						"Teleporter":
							body.interactuableDoor = 101_1_0_1
				
				"world_1.1":
					body.interactuableDoor = 101_1_1_1
					body.interactuableDoor2 = 101_1_1_1


func _on_teleporter_area_2d_body_exited(body):
	if body.name == "Player":
		body.hide_interact_label()
		body.interactuableDoor = 0
		body.interactuableDoor2 = 0

func unlock():
	$AnimatedSprite2D.play("active")
	unlocked = true
