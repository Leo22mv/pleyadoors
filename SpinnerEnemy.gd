extends StaticBody2D

var damage = 0.5


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sprite2D.play("default")


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.hurt(damage, 1)


func _on_area_2d_2_body_entered(body):
	if body.name == "Player":
		body.hurt(damage, -1)
