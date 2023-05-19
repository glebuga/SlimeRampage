extends CharacterBody2D


# Характеристики персонажа
var player_alive = true # Переменная, жив наш персонаж или нет
#характеристики пули
@export var BULLET_SPEED = 500 # Скорость пули
var bullet = preload("res://game/player/bullet/bullet.tscn") # Загружаем сцену пули
var can_fire = true
# Характеристики для взаимодействия с врагом
var enemy_inattack_range = false # Переменная, входит ли враг в область хитбокса 
var enemy_attack_cooldown = true

signal refresh_health


func _ready():
	pass


func _process(_delta):
	player_shoot() # Вызов функции стрельбы персонажа
	
	
func _physics_process(delta):
	player_movement(delta) # Вызов функции передвижения персонажа
	enemy_attack() # Вызов функции атаки по персонажу
	
	if Global.Сurrent_Health_Player <= 0:
		player_alive = false # здесь может быть конечный экран при смерти мерсонажа
		Global.Сurrent_Health_Player = 0
		print("player has been killed")
		self.queue_free()
	
		
# Функция передвижения
func player_movement(_delta):
	velocity = Vector2.ZERO
	if Input.is_action_pressed("run_right"):
		velocity.x += 1
	if Input.is_action_pressed("run_left"):
		velocity.x -= 1
	if Input.is_action_pressed("run_down"):
		velocity.y += 1
	if Input.is_action_pressed("run_top"):
		velocity.y -= 1
	velocity = velocity.normalized() * Global.Speed_Player
	move_and_slide()


# Функция стрельбы
func player_shoot():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("shoot_top") and can_fire: 
		var bullet_instance = bullet.instantiate()
		bullet_instance.position = get_global_position()
		bullet_instance.linear_velocity = Vector2(0, -BULLET_SPEED)
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		await(get_tree().create_timer(Global.Fire_Rate_Player).timeout)
		can_fire = true
	if Input.is_action_pressed("shoot_down") and can_fire: 
		var bullet_instance = bullet.instantiate()
		bullet_instance.position = get_global_position()
		bullet_instance.linear_velocity = Vector2(0, +BULLET_SPEED)
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		await(get_tree().create_timer(Global.Fire_Rate_Player).timeout)
		can_fire = true
	if Input.is_action_pressed("shoot_left") and can_fire: 
		var bullet_instance = bullet.instantiate()
		bullet_instance.position = get_global_position()
		bullet_instance.linear_velocity = Vector2(-BULLET_SPEED, 0)
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		await(get_tree().create_timer(Global.Fire_Rate_Player).timeout)
		can_fire = true
	if Input.is_action_pressed("shoot_right") and can_fire: 
		var bullet_instance = bullet.instantiate()
		bullet_instance.position = get_global_position()
		bullet_instance.linear_velocity = Vector2(+BULLET_SPEED, 0)
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		await(get_tree().create_timer(Global.Fire_Rate_Player).timeout)
		can_fire = true


# Метод игрока
func player():
	pass


# Обработка сигнала, когда что-то поподает в коллизию хитбокса
func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true
		
		
# Обработка сигнала, когда что-то выходит из коллизию хитбокса
func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false

# Обработка получения урона персонажем 
func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown:
		Global.Сurrent_Health_Player = Global.Сurrent_Health_Player - Global.Damage_Enemy
		refresh_health.emit()
		enemy_attack_cooldown = false
		$time_of_taking_damage.start()
		print("player took 1 gamage")


func _on_time_of_taking_damage_timeout():
	enemy_attack_cooldown = true
