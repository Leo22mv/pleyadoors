extends CharacterBody2D

var damage = 0.5

var speed = 150

var position_0
var position_1

var direction = true

# Called when the node enters the scene tree for the first time.
func _ready():
	position_0 = position
	
	if get_parent().get_parent().get_parent().name == "World1_1":
		if name == "MobileEnemy" || name == "MobileEnemy20" || name == "MobileEnemy31":
			position_1 = Vector2(position_0.x + 896, position_0.y)
		
		for i in range(14, 19):
			if name == "MobileEnemy" + str(i):
				position_1 = Vector2(position_0.x + 896, position_0.y)
		
		for i in range(2, 14):
			if name == "MobileEnemy" + str(i):
				position_1 = Vector2(position_0.x + 384, position_0.y)
				$Timer.set_wait_time(5.43)
		
		for i in range(21, 29):
			if name == "MobileEnemy" + str(i):
				position_1 = Vector2(position_0.x, position_0.y - 320)
		
		if name == "MobileEnemy19":
			position_1 = Vector2(position_0.x, position_0.y - 320)
		
		if name == "MobileEnemy29" || name == "MobileEnemy30":
			position_1 = Vector2(position_0.x + 256, position_0.y)
		
		if name == "MobileEnemy32":
			position_1 = Vector2(position_0.x + 640, position_0.y)
	
	
	if get_parent().get_parent().name == "Level2_1":
		position_1 = Vector2(position_0.x + 1088, position_0.y)
	
	
#	print(position, position_0, position_1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	velocity.x += delta * speed
	$Sprite2D.play("default")
	
	if name == "MobileEnemy" || name == "MobileEnemy20" || name == "MobileEnemy29" || name == "MobileEnemy30" || name == "MobileEnemy31" || name == "MobileEnemy32":
		if position.x >= position_0.x && position.x <= position_1.x:
				if direction:
					position.x += delta * speed
				else:
					position.x -= delta * speed

	for i in range(2, 19):
		if name == "MobileEnemy" + str(i):
			if position.x >= position_0.x && position.x <= position_1.x:
				if direction:
					position.x += delta * speed
				else:
					position.x -= delta * speed

	for i in range(21, 29):
		if name == "MobileEnemy" + str(i):
			if position.y <= position_0.y && position.y >= position_1.y:
				if direction:
					position.y -= delta * speed
				else:
					position.y += delta * speed

	if name == "MobileEnemy19":
		if position.y <= position_0.y && position.y >= position_1.y:
			if direction:
				position.y -= delta * speed
			else:
				position.y += delta * speed



	if name == "MobileEnemy" || name == "MobileEnemy20" || name == "MobileEnemy29" || name == "MobileEnemy30" || name == "MobileEnemy31" || name == "MobileEnemy32":
		if direction:
			if position.x >= position_1.x:
				if $Timer.is_stopped():
					$Timer.start()
		else:
			if position.x <= position_0.x:
				if $Timer.is_stopped():
					$Timer.start()

	for i in range(2, 19):
		if name == "MobileEnemy" + str(i):
			if direction:
				if position.x >= position_1.x:
					if $Timer.is_stopped():
						$Timer.start()
			else:
				if position.x <= position_0.x:
					if $Timer.is_stopped():
						$Timer.start()

	for i in range(21, 29):
		if name == "MobileEnemy" + str(i):
			if direction:
				if position.y <= position_1.y:
					if $Timer.is_stopped():
						$Timer.start()
			else:
				if position.y >= position_0.y:
					if $Timer.is_stopped():
						$Timer.start()

	if name == "MobileEnemy19":
		if direction:
			if position.y <= position_1.y:
				if $Timer.is_stopped():
					$Timer.start()
		else:
			if position.y >= position_0.y:
				if $Timer.is_stopped():
					$Timer.start()

	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.hurt(damage, 1)


func _on_area_2d_2_body_entered(body):
	if body.name == "Player":
		body.hurt(damage, -1)


func _on_timer_timeout():
	if direction:
		for i in range(21, 29):
			if name == "MobileEnemy" + str(i):
				position.y += 3
		
		
		if name == "MobileEnemy" || name == "MobileEnemy20" || name == "MobileEnemy29" || name == "MobileEnemy30" || name == "MobileEnemy31" || name == "MobileEnemy32":
			position.x -= 3
		
		for i in range(2, 19):
			if name == "MobileEnemy" + str(i):
				position.x -= 3
		
		if name == "MobileEnemy19":
			position.y += 3
		
	else:
		
		for i in range(21, 29):
			if name == "MobileEnemy" + str(i):
				position.y -= 3
		
		
		if name == "MobileEnemy" || name == "MobileEnemy20" || name == "MobileEnemy29" || name == "MobileEnemy30" || name == "MobileEnemy31" || name == "MobileEnemy32":
			position.x += 3
			
		for i in range(2, 19):
			if name == "MobileEnemy" + str(i):
				position.x += 3
		
		if name == "MobileEnemy19":
			position.y -= 3
	
	direction = !direction
