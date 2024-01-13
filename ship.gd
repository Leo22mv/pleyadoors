extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_ship_area_2d_body_entered(body):
	if body.name == "Player":
		$Label.show()
		get_tree().get_first_node_in_group("Player").interactuableDoor = 1


func _on_ship_area_2d_body_exited(body):
	$Label.hide()
	get_tree().get_first_node_in_group("Player").interactuableDoor = 0
