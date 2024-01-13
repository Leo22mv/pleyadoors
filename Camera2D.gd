extends Camera2D


# Variables de sacudida de pantalla
var shake_amount = 0
var default_offset = offset
var pos_x
var pos_y

@onready var timer = $Timer
@onready var tween = create_tween()

var shaking = false


# Función _process para actualizar la sacudida de pantalla
func _process(delta):
	offset = Vector2(randf_range(-1, 1) * shake_amount, randf_range(-1, 1) * shake_amount)


func screen_shake(time, amount):
	timer.wait_time = time
	shake_amount = amount
	set_process(true)
	timer.start()
	shaking = true

func _on_timer_timeout():
	set_process(false)
	tween.interpolate_value(self, "offset", 1, 1, tween.TRANS_LINEAR, tween.EASE_IN)
	shaking = false
