extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction

var player_detected = false
var have_floor_forward = true
var h_fliped = false

var curHp = 2
var maxHp = 2

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY

#	direction = 0
	
	if $RayCast2D3.is_colliding():
		if $RayCast2D3.get_collider().name == "Player" && $AttackCooldownTimer.is_stopped() && $AttackDelayTimer.is_stopped():
			direction = 1
	
	
	
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.play("run")
		if $RayCast2D.is_colliding():
			direction = 0
			if !h_fliped:
				if $RayCast2D.get_collider().name == "Player" && $AttackCooldownTimer.is_stopped() && $AttackDelayTimer.is_stopped():
					$AnimatedSprite2D.play("attack")
					$AttackDelayTimer.start()
				else:
					$AnimatedSprite2D.play("idle")
					$IdleTimer.start()
			else:
				scale.x = -1
				position.x += 64
				h_fliped = false
				$AnimatedSprite2D.play("idle")
	
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if !$AnimatedSprite2D.is_playing():
			$AnimatedSprite2D.play("idle")


	move_and_slide()

func _process(delta):
	if $RayCast2D.enabled == false:
		$RayCast2D.enabled = true


func _on_animated_sprite_2d_animation_finished():
	pass


func _on_attack_cooldown_timer_timeout():
	if $RayCast2D3.is_colliding():
		if !$RayCast2D3.get_collider().name == "Player":
			$IdleTimer.start()


func _on_attack_delay_timer_timeout():
	get_tree().get_first_node_in_group("Player").hurt(0.5, 1)
	$AttackCooldownTimer.start()


func _on_idle_timer_timeout():
	position.x -= 64
	scale.x = -1
	direction = -1
	h_fliped = true
	$RayCast2D.enabled = false


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.hurt(5, 1)

func hurt(damage, direction):
	curHp -= damage
	if direction == 1:
		velocity.x = 200
		velocity.y = -50
	elif direction == -1:
		velocity.x = -200
		velocity.y = -50
	move_and_slide()
