extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		queue_free()
		Save.game_data.player.keys.golden = 1
		get_tree().get_first_node_in_group("Player").keys.golden += 1
		get_tree().get_first_node_in_group("gui").update_keys()
		for world in Save.game_data.world:
			if get_parent().get_parent().name == world.node_name:
				world.collected_keys.append(name)
		Save.save_data()
