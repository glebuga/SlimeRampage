extends Area2D

@export var fire_rate_bonus = -0.1
@export var damage_bonus = 2

func _on_body_entered(body):
	if body.is_in_group("player"):
		Global.inventory.append(self)
		Global.Fire_Rate_Player += fire_rate_bonus
		Global.Damage_Player += damage_bonus
		queue_free()
	print(Global.inventory)
