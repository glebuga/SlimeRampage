extends Area2D

@export var health_bonus = 2

func _on_body_entered(body):
	if body.is_in_group("player"):
		Global.inventory.append(self)
		Global.Health_Player += health_bonus
		queue_free()
	print(Global.inventory)
