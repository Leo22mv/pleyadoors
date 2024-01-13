extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if $Control/QuitPopup.visible:
			_on_no_confirm_quit_button_button_up()
		
		if $Control/QuitPopup2.visible:
			_on_no_confirm_quit_to_menu_button_button_up()
		
		if $Control/LoadGameMenu.visible:
			$Control/LoadGameMenu._on_return_button_button_up()
		
		if $Control/SaveGameMenu.visible:
			$Control/SaveGameMenu._on_return_button_button_up()
		
		if $Control/OptionsMenu.visible:
			$Control/OptionsMenu._on_return_button_button_up()
			
		get_tree().paused = not get_tree().paused
		$Control.visible = not $Control.visible
		
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	
#	$Control.position.x = get_parent().get_child(5).position.x - 960
#	$Control.position.y = get_parent().get_child(5).position.y - 540


func show_popup():
	$Control/QuitButton.disabled = true
	$Control/ResumeButton.disabled = true
	$Control/SaveButton.disabled = true
	$Control/LoadButton.disabled = true
	$Control/OptionsButton.disabled = true
	$Control/QuitToMenuButton.disabled = true

func hide_popup():
	$Control/QuitButton.disabled = false
	$Control/ResumeButton.disabled = false
	$Control/SaveButton.disabled = false
	$Control/LoadButton.disabled = false
	$Control/OptionsButton.disabled = false
	$Control/QuitToMenuButton.disabled = false

func hide_buttons():
	$Control/ResumeButton.hide()
	$Control/SaveButton.hide()
	$Control/LoadButton.hide()
	$Control/OptionsButton.hide()
	$Control/QuitToMenuButton.hide()
	$Control/QuitButton.hide()

func show_buttons():
	$Control/ResumeButton.show()
	$Control/SaveButton.show()
	$Control/LoadButton.show()
	$Control/OptionsButton.show()
	$Control/QuitToMenuButton.show()
	$Control/QuitButton.show()


func _on_quit_button_button_up():
	show_popup()
	$Control/QuitPopup.show()
#	if get_parent().name != "Level3":
#		$Control/PointLight2D.enabled = false


func _on_no_confirm_quit_button_button_up():
	hide_popup()
	$Control/QuitPopup.hide()
	if get_parent().name != "Level3" && get_parent().name != "World1":
		$Control/PointLight2D.enabled = true


func _on_confirm_quit_button_button_up():
	get_tree().quit()


func _on_resume_button_button_up():
	get_tree().paused = not get_tree().paused
	$Control.visible = not $Control.visible
	
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_save_button_button_up():
	show_popup()
	hide_buttons()
	$Control/SaveGameMenu.update_buttons_info()
	$Control/SaveGameMenu.show()
	get_tree().get_first_node_in_group("gui").hide()


func _on_load_button_button_up():
	show_popup()
	hide_buttons()
	$Control/LoadGameMenu.update_buttons_info()
	$Control/LoadGameMenu.show()
	get_tree().get_first_node_in_group("gui").hide()


func _on_options_button_button_up():
	show_popup()
	hide_buttons()
	$Control/OptionsMenu.show()
	get_tree().get_first_node_in_group("gui").hide()


func _on_quit_to_menu_button_button_up():
	show_popup()
	$Control/QuitPopup2.show()


func _on_confirm_quit_to_menu_button_button_up():
	get_tree().paused = not get_tree().paused
	get_tree().change_scene_to_file("res://MainMenu.tscn")


func _on_no_confirm_quit_to_menu_button_button_up():
	hide_popup()
	$Control/QuitPopup2.hide()
