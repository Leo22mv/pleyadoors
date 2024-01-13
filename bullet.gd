extends StaticBody2D

const speed = 500

var direction = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if direction == 1:
		position.x += delta * speed


func _on_area_2d_body_entered(body):
	if body.has_method("hurt"):
		body.hurt(0.5, 1)
	queue_free()
