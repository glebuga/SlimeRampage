extends Area2D

@export var fire_rate_bonus = -0.2

func _on_body_entered(body):
	if body.is_in_group("player"):
		Global.inventory.append(self)
		Global.Fire_Rate_Player += fire_rate_bonus
		queue_free()
	print(Global.inventory)
