extends CharacterBody2D


var SPEED = 300.0
#const SPEED = 1000.0
const JUMP_VELOCITY = -1000.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 3

var coyote_time = 0.1

var curHp = 3
var maxHp = 3

var hurtDisplacementDirection = 0

var curGems = 0

var keys = {
	"red": 0,
	"green": 0,
	"golden": 0
}

var interactuableDoor = 0
var interactuableDoor2 = 0

var dashCounter = 0
var dashDirection = 1
var dashCooldown = 0

var isOnShip = false

var storeOpened = false

var travel_gui_opened = false
var travel_gui_focused_planet = 1
var travel_gui_displacement_counter = 0

var interactuable_planet

var ladder_near = false
var is_on_ladder = false

var newGame = true

var is_jumping = false

var h_fliped = false

var invulnerable = false

var second_jump_available = true

func _ready():
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor() and dashCounter == 0 and !isOnShip and !is_on_ladder:
		velocity.y += gravity * delta
		if $Node2D/AnimatedSprite2D.is_playing():
			if $Node2D/AnimatedSprite2D.animation != "die":
				$Node2D/AnimatedSprite2D.play("jump")
		if velocity.y > 0:
			if $Node2D/AnimatedSprite2D.animation != "die":
				$Node2D/AnimatedSprite2D.play("fall")
	else:
		if !is_jumping:
			coyote_time = 0.1
	
	if is_on_floor():
		is_jumping = false
		second_jump_available = true

	if !isOnShip and !is_on_ladder:
		if !ladder_near:
			# Second Jump.
			if Input.is_action_just_pressed("up") and (is_jumping or (not is_on_floor() and coyote_time == 0)) and second_jump_available:
				$Node2D/CPUParticles2D.emitting = true
				velocity.y = JUMP_VELOCITY
				second_jump_available = false
			
			# Handle Jump.
			if Input.is_action_just_pressed("up") and (is_on_floor() or coyote_time > 0) and dashCounter == 0:
				velocity.y = JUMP_VELOCITY
				is_jumping = true
		else:
			if Input.is_action_just_pressed("down") || Input.is_action_just_pressed("up"):
				if !is_on_ladder:
#					set_collision_mask(3)
					is_on_ladder = true
					velocity.y = 0
	else:
		if Input.is_action_pressed("up"):
			if isOnShip:
				position.y -= 20
			else:
				position.y -= 5
				$Node2D/AnimatedSprite2D.play("climb")
		elif Input.is_action_pressed("down"):
			if isOnShip:
				position.y += 20
			else:
				position.y += 5
				$Node2D/AnimatedSprite2D.play("climb")
		else:
			$Node2D/AnimatedSprite2D.stop()
	
	# Actualizar el tiempo de espera (Coyote Time)
	coyote_time = max(0, coyote_time - delta)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if $HurtDisplacementTimer.is_stopped():
		if direction:
			if newGame:
				newGame = false
			dashDirection = direction
			if not isOnShip and not is_on_ladder and is_on_floor():
#				$Node2D/AnimatedSprite2D.scale = Vector2(3, 3)
				if $Node2D/AnimatedSprite2D.animation != "jab" && $Node2D/AnimatedSprite2D.animation != "die":
					$Node2D/AnimatedSprite2D.play("walk")
			velocity.x = direction * SPEED
			if direction == 1:
				if h_fliped && $Node2D/AnimatedSprite2D.animation != "jab" && $Node2D/AnimatedSprite2D.animation != "die":
					$Node2D.scale.x = 1
					h_fliped = false
#					$InteractLabel.scale.x = -1
					var new_dash_particle_texture = load("res://Assets/Particles/dash.png")
					$Node2D/GPUParticles2D.texture = new_dash_particle_texture
			elif direction == -1:
				if !h_fliped && $Node2D/AnimatedSprite2D.animation != "jab" && $Node2D/AnimatedSprite2D.animation != "die":
					$Node2D.scale.x = -1
					h_fliped = true
#					$InteractLabel.scale.x = -1
					var new_dash_particle_texture = load("res://Assets/Particles/dash_h_fliped.png")
					$Node2D/GPUParticles2D.texture = new_dash_particle_texture
		else:
			if not isOnShip and not is_on_ladder and is_on_floor():
#				$Node2D/AnimatedSprite2D.scale = Vector2(1, 1)
				if $Node2D/AnimatedSprite2D.animation != "jab" && $Node2D/AnimatedSprite2D.animation != "die":
					$Node2D/AnimatedSprite2D.play("idle")
			velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		velocity.x = hurtDisplacementDirection * 1000
	
	if $Node2D/AnimatedSprite2D.animation == "jab":
		direction = 0
		velocity = Vector2.ZERO
	
	
	if $Node2D/AnimatedSprite2D.animation == "die":
		if is_on_floor():
			direction = 0
			velocity = Vector2.ZERO
	
#	if Input.is_action_pressed("up"):
#		velocity.y -= gravity * delta
	
	
	
	if Input.is_action_just_pressed("ui_accept"):
		if !isOnShip:
			if dashCooldown == 0:
				dashCounter = 5
				$Node2D/GPUParticles2D.emitting = true
	
	if Input.is_action_just_pressed("interact") and interactuableDoor != 0:
		match interactuableDoor:
			0_1.1:
				if !isOnShip:
					save()
					if get_parent().locked:
						get_parent().unlock()
					else:
						get_parent().win()
					
			0_2.0:
				if !isOnShip:
					save()
					get_parent().returnToLastLevel()
			0_2.1:
				if !isOnShip:
					save()
					if get_parent().locked1:
						get_parent().unlock1()
					else:
						get_parent().enter1()
			
			0_2.11:
				if !isOnShip:
					save()
					Save.game_data.actualworld = "level_2"
					Save.game_data.player.position.x = 4512
					Save.game_data.player.position.y = 2112
					Save.game_data.actualworldcoords = [96, 128]
					Save.save_data()
					get_tree().change_scene_to_file("res://level_2.tscn")
			
			0_2.2:
				if !isOnShip:
					save()
					if get_parent().locked:
						get_parent().unlock()
					else:
						Save.game_data.actualworld = "level_3"
						Save.game_data.player.position.x = 96
						Save.game_data.player.position.y = 832
						Save.game_data.actualworldcoords = [96, 832]
#						Save.game_data.world[0].uncollected_gems.clear()
#						for gem in get_tree().get_first_node_in_group("gems2").get_children():
#							Save.game_data.world[0].uncollected_gems.append(gem.name)
						Save.game_data.ship.position.x = 4896
						Save.game_data.ship.position.y = 760
						Save.save_data()
						get_tree().change_scene_to_file("res://level_3.tscn")
			
			0_3.0:
				if !isOnShip:
					save()
					Save.game_data.actualworld = "level_2"
					Save.game_data.player.position.x = 224
					Save.game_data.player.position.y = 128
					Save.game_data.actualworldcoords = [96, 128]
					Save.game_data.ship.position.x = get_tree().get_first_node_in_group("ship").position.x
					Save.game_data.ship.position.y = get_tree().get_first_node_in_group("ship").position.y
					Save.save_data()
					get_tree().change_scene_to_file("res://level_2.tscn")
			
			1_1:
				if get_parent().door_1_locked:
					if keys.golden > 0:
						get_parent().unlock_door_1()
				else:
					if !isOnShip:
						save()
						Save.game_data.actualworld = "world_1.1"
						Save.game_data.player.position.x = 256
						Save.game_data.player.position.y = 768
						Save.game_data.actualworldcoords = [256, 768]
						Save.game_data.ship.position.x = get_tree().get_first_node_in_group("ship").position.x
						Save.game_data.ship.position.y = get_tree().get_first_node_in_group("ship").position.y
						Save.save_data()
						get_tree().change_scene_to_file("res://world_1.1.tscn")
			
			1_1_0:
				if !isOnShip:
					save()
					Save.game_data.actualworld = "world_1"
					Save.game_data.player.position.x = 8416
					Save.game_data.player.position.y = 832
					Save.game_data.player.isonship = false
					Save.game_data.actualworldcoords = [768, 832]
					Save.game_data.ship.position.x = 7904
					Save.game_data.ship.position.y = 760
					Save.save_data()
					get_tree().change_scene_to_file("res://world_1.tscn")
			
			1_1_1:
				if get_parent().door_1_locked:
					if keys.green > 0:
						get_parent().unlock_door_1()
				else:
					save()
					Save.game_data.actualworld = "world_1.1.1"
					Save.game_data.player.position.x = 256
					Save.game_data.player.position.y = 384
					Save.game_data.actualworldcoords = [256, 384]
					Save.save_data()
					get_tree().change_scene_to_file("res://world_1.1.1.tscn")
			
			1_1_1_0:
				save()
				Save.game_data.actualworld = "world_1.1"
				Save.game_data.player.position.x = 5792
				Save.game_data.player.position.y = 3136
				Save.game_data.actualworldcoords = [256, 768]
				Save.save_data()
				get_tree().change_scene_to_file("res://world_1.1.tscn")
			
			1_1_2:
				if get_parent().door_2_locked:
					if keys.green > 0:
						get_parent().unlock_door_2()
				else:
					save()
					Save.game_data.actualworld = "world_1.1.2"
					Save.game_data.player.position.x = 1664
					Save.game_data.player.position.y = 384
					Save.game_data.actualworldcoords = [1664, 384]
					Save.save_data()
					get_tree().change_scene_to_file("res://world_1.1.2.tscn")
			
			1_1_2_0:
				save()
				Save.game_data.actualworld = "world_1.1"
				Save.game_data.player.position.x = 5472
				Save.game_data.player.position.y = -64
				Save.game_data.actualworldcoords = [256, 768]
				Save.save_data()
				get_tree().change_scene_to_file("res://world_1.1.tscn")
			
			1_2:
				pass
			
			1_3:
				pass
			
			# Ship
			1:
				if !isOnShip:
					isOnShip = true
					position = get_tree().get_first_node_in_group("ship").position
					get_tree().get_first_node_in_group("ship").get_child(1).disabled = true
					get_tree().get_first_node_in_group("ship").hide()
					$Node2D/AnimatedSprite2D.play("ship")
					Save.game_data.player.isonship = true
					Save.save_data()
					save()
					set_collision_mask(2)
					velocity = Vector2.ZERO
					get_tree().get_first_node_in_group("camera").set_position_smoothing_speed(10)
				else:
					if is_on_floor() && position.y >= 760:
						isOnShip = false
						get_tree().get_first_node_in_group("ship").get_child(1).disabled = false
						get_tree().get_first_node_in_group("ship").show()
						$Label.hide()
						Save.game_data.player.isonship = false
						Save.save_data()
						save()
						set_collision_mask(1)
						get_tree().get_first_node_in_group("ship").get_child(3).show()
						for child in get_tree().get_first_node_in_group("ship").get_children():
							if child.name == "RayCast2D":
								if child.is_colliding():
									position.x += 64
						get_tree().get_first_node_in_group("camera").set_position_smoothing_speed(5)
						if Input.is_action_pressed("down"):
							get_tree().get_first_node_in_group("ship").position.y -= 20
						$Node2D/AnimatedSprite2D.play("fall")
				
				
			
			# Hospital
			911:
				curHp = maxHp
				get_tree().get_first_node_in_group("gui").update_health()
				get_parent().showHospitalLabel()
				save()
			
			# Store
			15:
				if !storeOpened:
					get_tree().get_first_node_in_group("gui").get_child(3).show()
#					get_tree().get_first_node_in_group("gui").get_child(3).get_child(4).show()
					Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				else:
					if get_tree().get_first_node_in_group("gui").get_child(3).get_child(3).name == "InsufficientMoneyLabel":
						get_tree().get_first_node_in_group("gui").get_child(3).get_child(3).hide()
					get_tree().get_first_node_in_group("gui").get_child(3).hide()
					Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				
				storeOpened = !storeOpened
			
			# Rocket
			99:
				for child in get_parent().get_children():
					if child.name == "TravelGui":
						if child.visible:
							child.hide()
							travel_gui_opened = false
						else:
							child.update_planet_1()
							child.update_planet_2()
							child.show()
							travel_gui_opened = true
#							if travel_gui_focused_planet == 
			
			# Tutorial Screens
			100_1:
				get_parent().change_tutorial_screen_1_visibility()
				$InteractLabel.visible = !$InteractLabel.visible
			100_2:
				get_parent().change_tutorial_screen_2_visibility()
				$InteractLabel.visible = !$InteractLabel.visible
			100_3:
				get_parent().change_tutorial_screen_3_visibility()
				$InteractLabel.visible = !$InteractLabel.visible
			100_4:
				get_parent().change_tutorial_screen_4_visibility()
				$InteractLabel.visible = !$InteractLabel.visible
			100_0_2.1:
				get_parent().change_tutorial_screen_1_visibility()
				$InteractLabel.visible = !$InteractLabel.visible
			100_0_2.2:
				get_parent().change_tutorial_screen_2_visibility()
				$InteractLabel.visible = !$InteractLabel.visible
			100_0_2.1_1:
				get_parent().change_tutorial_screen_1_visibility()
				$InteractLabel.visible = !$InteractLabel.visible
			100_0_2.1_2:
				get_parent().change_tutorial_screen_2_visibility()
				$InteractLabel.visible = !$InteractLabel.visible
			100_0_3_1:
				get_parent().change_tutorial_screen_1_visibility()
				$InteractLabel.visible = !$InteractLabel.visible
			100_0_3_2:
				get_parent().change_tutorial_screen_2_visibility()
				$InteractLabel.visible = !$InteractLabel.visible
			100_0_3_3:
				get_parent().change_tutorial_screen_3_visibility()
				$InteractLabel.visible = !$InteractLabel.visible
			100_0_3_4:
				get_parent().change_tutorial_screen_4_visibility()
				$InteractLabel.visible = !$InteractLabel.visible
			100_1_1_1:
				get_parent().change_tutorial_screen_1_visibility()
				$InteractLabel.visible = !$InteractLabel.visible
			
			
			# Teleporters
			101_1_1_1:
				Save.game_data.actualworld = "world_1"
				Save.game_data.player.position.x = 4224
				Save.game_data.player.position.y = 832
				Save.game_data.player.isonship = false
				Save.game_data.actualworldcoords = [768, 832]
#				print(Save.game_data.world[3].unlocked_teleporters.find("Teleporter"))
				if Save.game_data.world[3].unlocked_teleporters.find("Teleporter") == -1:
					Save.game_data.world[3].unlocked_teleporters.append("Teleporter")
				Save.game_data.ship.position.x = 5792
				Save.game_data.ship.position.y = 760
				Save.save_data()
				get_tree().change_scene_to_file("res://world_1.tscn")
			
			101_1_0_1:
				Save.game_data.actualworld = "world_1.1"
				Save.game_data.player.position.x = 4928
				Save.game_data.player.position.y = 3040
				Save.game_data.player.isonship = false
				Save.game_data.actualworldcoords = [256, 768]
				Save.save_data()
				get_tree().change_scene_to_file("res://world_1.1.tscn")
		
		interactuableDoor2 = 0

	if !isOnShip:
		if dashCounter > 0:
			SPEED = 3000.0
			velocity.x = dashDirection * SPEED
			if dashCounter == 1:
				dashCooldown = 50
			dashCounter -= 1
			velocity.y = 0
		else:
			SPEED = 300.0
		
		if get_parent().name=="Level3" || get_parent().name == "World1":
			$ShipCollision.disabled = true
	else:
		SPEED = 2000.0
		$ShipCollision.disabled = false
	
	if isOnShip:
		get_tree().get_first_node_in_group("ship").position = position
	
	if storeOpened||travel_gui_opened:
		velocity = Vector2(0, 0)

	move_and_slide()
	
	if travel_gui_opened:
		if Input.is_action_just_pressed("right"):
			if travel_gui_focused_planet == 1:
				travel_gui_displacement_counter = 5760
		
		if Input.is_action_just_pressed("left"):
			if travel_gui_focused_planet == 2:
				travel_gui_displacement_counter = -5760
			
	if Input.is_action_just_pressed("attack") && is_on_floor() && !isOnShip && !is_on_ladder:
		if $Node2D/RayCast2D.is_colliding():
			if $Node2D/AnimatedSprite2D.animation != "jab":
				$AttackDelayTimer.start()
		$Node2D/AnimatedSprite2D.play("jab")

func _process(delta):
#	if $Node2D/RayCast2D.is_colliding():
#	print($HurtBlinkTimer/HurtBlinkingTimer.time_left)
#	if velocity.y > 0:
#		print(velocity.y)

	if velocity.y > 2000:
		get_tree().get_first_node_in_group("camera").set_position_smoothing_speed(10)
	else:
		get_tree().get_first_node_in_group("camera").set_position_smoothing_speed(5)

	if dashCooldown > 0:
		dashCooldown -= 1
		
	if isOnShip:
		interactuableDoor = 1
		if is_on_floor() && position.y >= 760:
			$Label.show()
		else:
			$Label.hide()
		$ComingSoonLabel.hide()
	
	match interactuableDoor2:
		0_2.1:
			interactuableDoor = 0_2.1
		0_2.2:
			interactuableDoor = 0_2.2
		0_1.1:
			interactuableDoor = 0_1.1
		1_1_1:
			interactuableDoor = 1_1_1
			$InteractLabel.show()
		
		101_1_1_1:
			interactuableDoor = 101_1_1_1
			$InteractLabel.show()
	
	if travel_gui_displacement_counter > 0:
		for child in get_tree().get_first_node_in_group("travel_gui").get_children():
			if travel_gui_focused_planet == 1:
				if child.name == "Sprite2D" || child.name == "Planet1" || child.name == "Planet2":
					child.position.x -= 192
					travel_gui_displacement_counter -= 192
					if travel_gui_displacement_counter == 0:
						travel_gui_focused_planet = 2
						if !Save.game_data.actualworld.begins_with("world"):
							interactuable_planet = 1
						else:
							interactuable_planet = null
	
	if travel_gui_displacement_counter < 0:
		for child in get_tree().get_first_node_in_group("travel_gui").get_children():
			if travel_gui_focused_planet == 2:
				if child.name == "Sprite2D" || child.name == "Planet1" || child.name == "Planet2":
					child.position.x += 192
					travel_gui_displacement_counter += 192
					if travel_gui_displacement_counter == 0:
						travel_gui_focused_planet = 1
						if !Save.game_data.actualworld.begins_with("level"):
							interactuable_planet = 0
						else:
							interactuable_planet = null
							
	
	if travel_gui_opened && Input.is_action_just_pressed("travel"):
		match interactuable_planet:
			0:
#				get_tree().change_scene_to_file("res://level_3.tscn")
				save()
				Save.game_data.actualworld = "level_3"
				Save.game_data.player.position.x = 9248
				Save.game_data.player.position.y = 832
				Save.game_data.player.isonship = false
				Save.game_data.actualworldcoords = [96, 832]
				Save.game_data.ship.position.x = 8416
				Save.game_data.ship.position.y = 760
				Save.save_data()
				get_tree().change_scene_to_file("res://level_3.tscn")
			
			1:
				save()
				Save.game_data.actualworld = "world_1"
				Save.game_data.player.position.x = 768
				Save.game_data.player.position.y = 832
				Save.game_data.player.isonship = false
				Save.game_data.actualworldcoords = [768, 832]
				Save.game_data.ship.position.x = 1312
				Save.game_data.ship.position.y = 760
				Save.save_data()
				get_tree().change_scene_to_file("res://world_1.tscn")
	
	

func hurt(damage, direction):
	if $HurtDisplacementTimer.is_stopped():
		if !invulnerable:
			curHp -= damage
			invulnerable = true
			velocity.y = -300
			$HurtDisplacementTimer.start()
			hurtDisplacementDirection = direction
			get_tree().get_first_node_in_group("gui").update_health()
			Save.game_data.player.hp.cur = curHp
			Save.save_data()
	#		var camera = get_tree().get_first_node_in_group("camera")
	#		camera.screen_shake(0.5, 0.5, camera.offset.x, camera.offset.y)
			if curHp > 0:
				$HurtBlinkTimer.start()
				$HurtBlinkTimer/HurtBlinkingTimer.start()
	

func die():
	curHp = maxHp
	Save.game_data.player.hp.cur = curHp
	Save.game_data.player.position.x = Save.game_data.actualworldcoords[0]
	Save.game_data.player.position.y = Save.game_data.actualworldcoords[1]
#	Save.game_data.player.keys.green = 0
#	Save.game_data.player.keys.red = 0
#	Save.game_data.player.gems = 0
#	if curHp == 3:
#		Save.game_data.world[0].uncollected_gems = ["Gem", "Gem2", "Gem3", "Gem4", "Gem5", "Gem6", "Gem7", "Gem8", "Gem9", "Gem10"]
	Save.save_data()
#	keys.clear()
	get_tree().reload_current_scene()

func give_gems(quantity):
	curGems += quantity
	get_tree().get_first_node_in_group("gui").update_gems()
	Save.game_data.player.gems = curGems
	Save.save_data()


func increaseMaxHealth():
	maxHp += 1
	curHp = maxHp
	get_tree().get_first_node_in_group("gui").get_child(0).get_child(3).show()
	get_tree().get_first_node_in_group("gui").update_health()
	Save.game_data.player.hp.max += 1

func save():
	Save.game_data.player.position.x = position.x
	Save.game_data.player.position.y = position.y
	Save.game_data.player.hp.cur = curHp
	Save.game_data.player.gems = curGems
#	match Save.game_data.actualworld:
#		"level_2":
#			Save.game_data.world[0].uncollected_gems.clear()
#			for gem in get_tree().get_first_node_in_group("gems2").get_children():
#				if gem.name != "BlueGems":
#					Save.game_data.world[0].uncollected_gems.append(gem.name)
#				else:
#					for child in gem.get_children():
#						Save.game_data.world[0].uncollected_gems.append(child.name)
#						print(child.name)
	
	if Save.game_data.actualworld == "level_3" || Save.game_data.actualworld == "world_1":
		Save.game_data.ship.position.x = get_tree().get_first_node_in_group("ship").position.x
		Save.game_data.ship.position.y = get_tree().get_first_node_in_group("ship").position.y
	
#	for key in keys:
#		match key:
#			"red":
#				Save.game_data.player.keys.red += 1
#
#			"green":
#				Save.game_data.player.keys.green += 1
	
	Save.save_data()

func show_interact_label():
	$InteractLabel.show()
func hide_interact_label():
	$InteractLabel.hide()


func _on_animated_sprite_2d_animation_finished():
	if $Node2D/AnimatedSprite2D.animation == "jab":
		$Node2D/AnimatedSprite2D.set_animation("idle")
		if Input.is_action_pressed("right"):
			if h_fliped:
				$Node2D.scale.x = 1
				h_fliped = false
				var new_dash_particle_texture = load("res://Assets/Particles/dash.png")
				$Node2D/GPUParticles2D.texture = new_dash_particle_texture
				$CollisionShape2D.position.x = 0.5
		elif Input.is_action_pressed("left"):
			if !h_fliped:
				$Node2D.scale.x = -1
				h_fliped = true
				var new_dash_particle_texture = load("res://Assets/Particles/dash_h_fliped.png")
				$Node2D/GPUParticles2D.texture = new_dash_particle_texture
				$CollisionShape2D.position.x = 0.5
	if $Node2D/AnimatedSprite2D.animation == "die":
		die()


func _on_hurt_displacement_timer_timeout():
	if curHp <= 0:
		$Node2D/AnimatedSprite2D.stop()
		$Node2D/AnimatedSprite2D.play("die")


func _on_hurt_blinking_timer_timeout():
	$Node2D/AnimatedSprite2D.visible = !$Node2D/AnimatedSprite2D.visible


func _on_hurt_blink_timer_timeout():
	$HurtBlinkTimer/HurtBlinkingTimer.stop()
	$Node2D/AnimatedSprite2D.visible = true
	$HurtBlinkTimer.stop()
	invulnerable = false


func _on_attack_delay_timer_timeout():
	if $Node2D/RayCast2D.get_collider().has_method("hurt"):
		print($Node2D/RayCast2D.get_collider().name)
#		$Node2D/RayCast2D.get_collider().hurt(1, -1 if $Node2D/AnimatedSprite2D.flip_h else 1)
		$Node2D/RayCast2D.get_collider().hurt(1, -1)
		get_tree().get_first_node_in_group("camera").screen_shake(0.1, 5)
	else:
		get_tree().get_first_node_in_group("camera").screen_shake(0.1, 2)
