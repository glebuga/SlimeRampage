extends HBoxContainer

var heart = preload("res://game/hud/heart_gui.tscn") # Загружаем сцену сердца


func _ready():
	for i in range(Global.Max_Health_Player):
		add_child(heart.instantiate())
	Global.taking_away_health_gui.connect(taking_away_health)
	Global.adding_health_gui.connect(adding_health)
	Global.increasing_max_health_gui.connect(increasing_max_health)
	Global.restart_health_gui.connect(restart_health)
	
func taking_away_health():
	# Найти последнее заполненное сердце
	for i in range(get_child_count() - 1, -1, -1):
		var heart = get_child(i)
		var sprite = heart.get_node("Sprite2D")
		if sprite.frame == 0:
			# Обновить фрейм сердца
			sprite.frame = 4
			break


func restart_health():
	for child in get_children():
		child.queue_free()
	for i in range(Global.Max_Health_Player):
		add_child(heart.instantiate())

func adding_health():
	# Найти первое пустое сердце
	for i in range(get_child_count()):
		var heart = get_child(i)
		var sprite = heart.get_node("Sprite2D")
		if sprite.frame == 4:
			# Обновить фрейм сердца
			sprite.frame = 0
			break


func increasing_max_health(diff):
	# Добавить новые сердца в начало контейнера
	for i in range(diff):
		var new_heart = heart.instantiate()
		add_child(new_heart)
		move_child(new_heart, 0)


	
