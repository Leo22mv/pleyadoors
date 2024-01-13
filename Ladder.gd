extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == "Player":
		get_tree().get_first_node_in_group("Player").ladder_near = true


func _on_body_exited(body):
	if body.name == "Player":
		get_tree().get_first_node_in_group("Player").ladder_near = false
		get_tree().get_first_node_in_group("Player").is_on_ladder = false
#		get_tree().get_first_node_in_group("Player").set_collision_mask(1)
