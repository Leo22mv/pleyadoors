extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_return_button_button_up():
	if get_parent().name == "Control":
		for child in get_parent().get_children():
			if child.name == "OptionsMenu":
				child.hide()
				get_parent().get_parent().hide_popup()
				get_parent().get_parent().show_buttons()
				get_tree().get_first_node_in_group("gui").show()
	else:
		get_tree().change_scene_to_file("res://MainMenu.tscn")
