extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var bulletInstance: PackedScene

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 3

var pointing = false

func _ready():
	$AnimatedSprite2D.play("default")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.hurt(5, -1)

func change_pointing():
	if !pointing:
		$Sprite2D.show()
		$Sprite2D2.show()
		$Sprite2D3.hide()
		$Timer.start()
	else:
		$Sprite2D.hide()
		$Sprite2D2.hide()
		$Sprite2D3.show()
		$Timer.stop()
	
	pointing = !pointing


func _on_timer_timeout():
	var instance = bulletInstance.instantiate()
	add_sibling(instance)
	instance.global_position = Vector2(1773, 1581)
