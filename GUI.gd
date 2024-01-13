extends Control

@onready var player = get_tree().get_first_node_in_group("Player")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	get_parent().position = get_parent().get_parent().get_child(5).position - Vector2(960, 540)
	pass

func update_health():
	$Life/Heart1.play("default")
	$Life/Heart2.play("default")
	$Life/Heart3.play("default")
	$Life/Heart4.play("default")
	match player.curHp:
		3.5:
			$Life/Heart4.play("half")
		3.0:
			$Life/Heart4.play("empty")
			
		2.5:
			$Life/Heart4.play("empty")
			$Life/Heart3.play("half")
		
		2.0:
			$Life/Heart4.play("empty")
			$Life/Heart3.play("empty")
			
		1.5:
			$Life/Heart4.play("empty")
			$Life/Heart3.play("empty")
			$Life/Heart2.play("half")
			
		1.0:
			$Life/Heart4.play("empty")
			$Life/Heart3.play("empty")
			$Life/Heart2.play("empty")
			
		0.5:
			$Life/Heart4.play("empty")
			$Life/Heart3.play("empty")
			$Life/Heart2.play("empty")
			$Life/Heart1.play("half")

func update_gems():
	$Gems/Label.text = str(player.curGems)

func update_keys():
	$Keys/AnimatedSprite2D2/Label.text = str(Save.game_data.player.keys.red)
	$Keys/AnimatedSprite2D2/Label.position.x = 0
	$Keys/AnimatedSprite2D2/Label.position.x -= $Keys/AnimatedSprite2D2/Label.size.x + 25
	$Keys/AnimatedSprite2D/Label.text = str(Save.game_data.player.keys.green)
	$Keys/AnimatedSprite2D/Label.position.x = 0
	$Keys/AnimatedSprite2D/Label.position.x -= $Keys/AnimatedSprite2D/Label.size.x + 25
	$Keys/AnimatedSprite2D3/Label.text = str(Save.game_data.player.keys.golden)
	$Keys/AnimatedSprite2D3/Label.position.x = 0
	$Keys/AnimatedSprite2D3/Label.position.x -= $Keys/AnimatedSprite2D3/Label.size.x + 25


func _on_texture_button_button_up():
	if get_tree().get_first_node_in_group("Player").curGems >= 25:
		$Store/Item.queue_free()
		get_tree().get_first_node_in_group("Player").increaseMaxHealth()
		get_tree().get_first_node_in_group("Player").curGems -= 25
		update_gems()
		$Store/VoidStoreLabel.show()
		get_tree().get_first_node_in_group("Player").save()
	else:
		$Store/InsufficientMoneyLabel.show()
