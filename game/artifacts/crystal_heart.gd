extends Area2D

@export var health_bonus = 2

func _on_body_entered(body):
	if body.is_in_group("player"):
		Global.inventory.append(self)
		Global.Max_Health_Player += health_bonus
		Global.from_artifact = true
		Global.Сurrent_Health_Player += health_bonus
		Global.from_artifact = false
		queue_free()
	print(Global.inventory)
