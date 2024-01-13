extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_rocket_area_body_entered(body):
	if body.name == "Player":
		for child in get_tree().get_first_node_in_group("Player").get_children():
			if child.name == "InteractLabel":
				child.show()
				get_tree().get_first_node_in_group("Player").interactuableDoor = 99


func _on_rocket_area_body_exited(body):
	if body.name == "Player":
		for child in get_tree().get_first_node_in_group("Player").get_children():
			if child.name == "InteractLabel":
				child.hide()
				get_tree().get_first_node_in_group("Player").interactuableDoor = 0
