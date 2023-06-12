extends Area2D

@export var damage_bonus = 5

func _on_body_entered(body):
	if body.is_in_group("player"):
		Global.inventory.append(self)
		Global.Damage_Player += damage_bonus
		queue_free()
	print(Global.inventory)
