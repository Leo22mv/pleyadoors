extends Control

# Load the custom images for the mouse cursor.
var cursorArrow = load("res://Assets/kenney_ui-pack-space-expansion/PNG/cursor_pointer3D_shadow.png")
var cursorPointer = load("res://Assets/kenney_ui-pack-space-expansion/PNG/cursor_hand.png")

var haveSavefile = true

func _ready():
#    pass
	Input.set_custom_mouse_cursor(cursorArrow)
#	Save.load_data()

func _process(delta):
#    Input.set_custom_mouse_cursor(beam)
	pass


func show_popup():
	$NewGameButton.disabled = true
	if !$LoadGameButton.disabled:
		$LoadGameButton.disabled = true
	$OptionsButton.disabled = true
	$QuitButton.disabled = true

func hide_popup():
	$NewGameButton.disabled = false
	if haveSavefile:
		$LoadGameButton.disabled = false
	$OptionsButton.disabled = false
	$QuitButton.disabled = false


func _on_button_4_button_up():
	show_popup()
	$QuitPopup.show()


func _on_options_button_button_up():
	get_tree().change_scene_to_file("res://OptionsMenu.tscn")


func _on_no_confirm_quit_button_button_up():
	hide_popup()
	$QuitPopup.hide()


func _on_confirm_quit_button_button_up():
	get_tree().quit()


func _on_new_game_button_button_up():
	get_tree().change_scene_to_file("res://new_game_menu.tscn")


func _on_load_game_button_button_up():
	get_tree().change_scene_to_file("res://load_game_menu.tscn")
