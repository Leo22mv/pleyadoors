extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var direction = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var damage = 0.5

func _ready():
	$AnimatedSprite2D.flip_h = true

func _physics_process(delta):
	# Add the gravity.
#	if not is_on_floor():
#		velocity.y += gravity * delta

	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.hurt(damage, 1)


func _on_area_2d_2_body_entered(body):
	if body.name == "Player":
		body.hurt(damage, -1)


func _on_idle_timer_timeout():
	$AnimatedSprite2D.flip_h = !$AnimatedSprite2D.flip_h
	$AnimatedSprite2D.play("default")
	if direction == -1:
		direction = 1
	else:
		direction = -1
	velocity.x = direction * SPEED
	$WalkTimer.start()


func _on_walk_timer_timeout():
	$AnimatedSprite2D.play("default")
	velocity.x = 0
	$IdleTimer.start()
