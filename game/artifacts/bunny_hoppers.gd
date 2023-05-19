extends Area2D

@export var speed_bonus = 10

func _on_body_entered(body):
	if body.is_in_group("player"):
		Global.inventory.append(self)
		Global.Speed_Player += speed_bonus
		queue_free()
	print(Global.inventory)
