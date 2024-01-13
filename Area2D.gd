extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == "Player":
		get_parent().queue_free()
		
		if get_parent().name.begins_with("Gem"):
			body.give_gems(1)
		elif get_parent().name.begins_with("BlueGem"):
			body.give_gems(10)
		
		for world in Save.game_data.world:
			if get_parent().get_parent().get_parent().get_parent().name == world.node_name:
				world.collected_gems.append(get_parent().name)
				Save.save_data()
			
			if get_parent().get_parent().get_parent().name == world.node_name:
				world.collected_gems.append(get_parent().name)
				Save.save_data()
