extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func hurt(damage, direction):
	for child in get_children():
#		print(child.get_child_count())
		for tile in child.get_children():
			if tile.name == "DestroyingWallParticles":
				tile.emitting = true
			if tile.name == "Sprite2D":
				tile.queue_free()
	for world in Save.game_data.world:
		if world.node_name == get_parent().get_parent().name:
			world.destroyed_walls.append(name)
			Save.save_data()
	$CollisionShape2D.queue_free()
