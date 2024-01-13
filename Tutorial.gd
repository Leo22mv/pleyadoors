extends Control

var actualFrame = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	if actualFrame  == 1:
		$Tutorial1/Label/AnimatedSprite2D.play("new_animation")
		$Tutorial1/Label/AnimatedSprite2D2.play("new_animation")
		$Tutorial1/Label/Label.position.y += 5
		$Tutorial1/Label/Label2.position.y += 5
		$Tutorial1/Label2/AnimatedSprite2D.play("new_animation")
		$Tutorial1/Label2/Label.position.y += 5
		$Tutorial1/Label5/AnimatedSprite2D.play("new_animation")
		$Tutorial1/Label5/Label.position.y += 5
		actualFrame = 2
	else:
		$Tutorial1/Label/AnimatedSprite2D.play("default")
		$Tutorial1/Label/AnimatedSprite2D2.play("default")
		$Tutorial1/Label/Label.position.y -= 5
		$Tutorial1/Label/Label2.position.y -= 5
		$Tutorial1/Label2/AnimatedSprite2D.play("default")
		$Tutorial1/Label2/Label.position.y -= 5
		$Tutorial1/Label5/AnimatedSprite2D.play("default")
		$Tutorial1/Label5/Label.position.y -= 5
		actualFrame = 1
