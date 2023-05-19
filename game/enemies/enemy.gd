extends CharacterBody2D


# Характеристики врага
var HEALTH = 2
var SPEED = 75
# Находится ли пуля в зоне хитбокса врага
var bullet_inattack_one = false


var player_chase = false
var player = null


var path = []
var path_index = 0

var key = preload("res://game/objects/key/key.tscn") # Загружаем сцену ключа


func _physics_process(delta):
	if player_chase:
		velocity = (player.position - position).normalized() * SPEED
	else:
		velocity = Vector2.ZERO
	move_and_collide(velocity * delta)
	
	deal_with_damage()
	
	if HEALTH <= 0:
		# Выпадение ключа
		var key_instance = key.instantiate()
		key_instance.position = get_global_position()
		get_tree().get_root().add_child(key_instance)
		
		print("enemy has been killed")
		self.queue_free()
	
	
func _on_detection_area_body_entered(body):
	player = body
	player_chase = true


func _on_detection_area_body_exited(body):
	player = null
	player_chase = false


func enemy():
	pass


func deal_with_damage():
	if bullet_inattack_one:
		HEALTH = HEALTH - Global.Damage_Player


func _on_enemy_hitbox_body_entered(body):
	if body.has_method("bullet_player"):
		bullet_inattack_one = true


func _on_enemy_hitbox_body_exited(body):
	if body.has_method("bullet_player"):
		bullet_inattack_one = false
