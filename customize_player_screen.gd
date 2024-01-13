extends Node2D

var zoomingIn = false
var zoomingOut = false

var canZoom = true

var actualColor = "red"
var actualFace = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("idle")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if zoomingIn:
		if $Camera2D.zoom < Vector2(3, 3):
			$Camera2D.zoom = $Camera2D.zoom + Vector2(0.2, 0.2)
			$Camera2D.position.y -= 5
		elif $Camera2D.zoom >= Vector2(3, 3):
			zoomingIn = false
		
	if zoomingOut:
		if $Camera2D.zoom > Vector2(1, 1):
			$Camera2D.zoom = $Camera2D.zoom - Vector2(0.2, 0.2)
			$Camera2D.position.y += 5
		elif $Camera2D.zoom <= Vector2(1, 1):
			zoomingOut = false




func _physics_process(delta):
	if Input.is_action_just_pressed("down"):
		if !zoomingIn && !zoomingOut && canZoom:
			zoomingIn = true
			$CanvasLayer/AnimatedSprite2D2.position.y += 150
			$CanvasLayer/AnimatedSprite2D3.position.y += 150
			canZoom = false
			
			$CanvasLayer/AnimatedSprite2D2.show()
			$CanvasLayer/AnimatedSprite2D3.show()
			
			if actualFace == 1:
				$CanvasLayer/AnimatedSprite2D3.hide()
			elif actualFace == 6:
				$CanvasLayer/AnimatedSprite2D2.hide()


	if Input.is_action_just_pressed("up"):
		if !zoomingIn && !zoomingOut && !canZoom:
			zoomingOut = true
			$CanvasLayer/AnimatedSprite2D2.position.y -= 150
			$CanvasLayer/AnimatedSprite2D3.position.y -= 150
			canZoom = true
			
			$CanvasLayer/AnimatedSprite2D2.show()
			$CanvasLayer/AnimatedSprite2D3.show()
			
			
			if actualColor == "red":
				$CanvasLayer/AnimatedSprite2D3.hide()
			elif actualColor == "black":
				$CanvasLayer/AnimatedSprite2D2.hide()
	
	
	
	
	if Input.is_action_just_pressed("right"):
		if canZoom && !zoomingIn && !zoomingOut:
			match actualColor:
				"red":
					actualColor = "blue"
				"blue":
					actualColor = "green"
				"green":
					actualColor = "white"
				"white":
					actualColor = "grey"
				"grey":
					actualColor = "black"
			
			var spriteFrames = load("res://Assets/Player spritesheets/SpriteFrames/" + actualColor + str(actualFace) + ".tres")
			var actualFrame = $AnimatedSprite2D.frame
			$AnimatedSprite2D.sprite_frames = spriteFrames
			$AnimatedSprite2D.frame = actualFrame
		
		
		if !canZoom && !zoomingIn && !zoomingOut:
			if actualFace < 6:
				var spriteFrames = load("res://Assets/Player spritesheets/SpriteFrames/" + actualColor + str(actualFace + 1) + ".tres")
				var actualFrame = $AnimatedSprite2D.frame
				$AnimatedSprite2D.sprite_frames = spriteFrames
				$AnimatedSprite2D.frame = actualFrame
				actualFace += 1
		
		$CanvasLayer/AnimatedSprite2D2/UnlockLabel.position.y += 3
	
	
	
	
	if Input.is_action_just_pressed("left"):
		if canZoom && !zoomingIn && !zoomingOut:
			match actualColor:
				"blue":
					actualColor = "red"
				"green":
					actualColor = "blue"
				"white":
					actualColor = "green"
				"grey":
					actualColor = "white"
				"black":
					actualColor = "grey"
			
			var spriteFrames = load("res://Assets/Player spritesheets/SpriteFrames/" + actualColor + str(actualFace) + ".tres")
			var actualFrame = $AnimatedSprite2D.frame
			$AnimatedSprite2D.sprite_frames = spriteFrames
			$AnimatedSprite2D.frame = actualFrame
		
		
		if !canZoom && !zoomingIn && !zoomingOut:
			
			if actualFace > 1:
				var spriteFrames = load("res://Assets/Player spritesheets/SpriteFrames/" + actualColor + str(actualFace - 1) + ".tres")
				var actualFrame = $AnimatedSprite2D.frame
				$AnimatedSprite2D.sprite_frames = spriteFrames
				$AnimatedSprite2D.frame = actualFrame
				actualFace -= 1
		
		
		$CanvasLayer/AnimatedSprite2D3/UnlockLabel.position.y += 3
	
	
	
	
	if Input.is_action_just_pressed("left") || Input.is_action_just_pressed("right"):
		$AnimatedSprite2D.play("idle")
		
		if canZoom:
			match actualColor:
				"red":
					$CanvasLayer/AnimatedSprite2D3.hide()
				"blue":
					$CanvasLayer/AnimatedSprite2D3.show()
				"grey":
					$CanvasLayer/AnimatedSprite2D2.show()
				"black":
					$CanvasLayer/AnimatedSprite2D2.hide()
		
		
		else:
			match actualFace:
					1:
						$CanvasLayer/AnimatedSprite2D3.hide()
					2:
						$CanvasLayer/AnimatedSprite2D3.show()
					5:
						$CanvasLayer/AnimatedSprite2D2.show()
					6:
						$CanvasLayer/AnimatedSprite2D2.hide()
	
	
	if Input.is_action_pressed("left"):
		$CanvasLayer/AnimatedSprite2D3.play("new_animation")
	else:
		$CanvasLayer/AnimatedSprite2D3.play("default")
	
	if Input.is_action_just_released("left"):
		$CanvasLayer/AnimatedSprite2D3/UnlockLabel.position.y -= 3
	
	
	if Input.is_action_pressed("right"):
		$CanvasLayer/AnimatedSprite2D2.play("new_animation")
	else:
		$CanvasLayer/AnimatedSprite2D2.play("default")
	
	if Input.is_action_just_released("right"):
		$CanvasLayer/AnimatedSprite2D2/UnlockLabel.position.y -= 3
	
	
	if Input.is_action_just_pressed("interact"):
		Save.game_data.player.color = actualColor
		Save.game_data.player.face = actualFace
		Save.save_data()
		get_tree().change_scene_to_file("res://level_1.tscn")
