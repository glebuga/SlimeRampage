extends HBoxContainer

var heart = preload("res://game/hud/heart_gui.tscn") # Загружаем сцену сердца


func _ready():
	for i in range(Global.Max_Health_Player):
		add_child(heart.instantiate())
	# Подписка на сигнал refresh_health
	$"../../Player".refresh_health.connect(_on_player_refresh_health)
	
	
func refresh_health():
	# Найти последнее заполненное сердце
	for i in range(get_child_count() - 1, -1, -1):
		var heart = get_child(i)
		var sprite = heart.get_node("Sprite2D")
		if sprite.frame == 0:
			# Обновить фрейм сердца
			sprite.frame = 4
			break


func _on_player_refresh_health():
	refresh_health()
