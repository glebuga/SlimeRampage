extends StaticBody2D

var player_nearby = false # Переменная, находится ли персонаж в зоне открытия сундука
var its_open = false # Переменная, для того чтобы понять, закрыт ли сундук


signal refresh_key


func _ready():
	
	# Начальное отображение сундука
	$opened.visible = false
	$closed.visible = true


func _physics_process(_delta):
	open_the_chest() # Вызов функции открытия сундука


# Функции открытия сундука
func open_the_chest():
	if player_nearby and Global.Key_Player > 0 and !its_open: # Условие, если игрок находится в зоне сундука и если ключей больше 0 и если сундук закрыт
		if Input.is_action_just_pressed("activation"): # Если нажата клавиша "Е"
			its_open = true
			Global.Key_Player -= 1 # Отнимаем ключ у глобальной переменной
			refresh_key.emit()
			# Меняем отображение сундука
			$opened.visible = true
			$closed.visible = false
			
			if Global.available_artifacts.size() > 0:
				var artifact_index = randi() % Global.available_artifacts.size()
				var artifact_scene = Global.available_artifacts[artifact_index]
				# Заменить выбранный артефакт последним элементом массива available_artifacts:
				Global.available_artifacts[artifact_index] = Global.available_artifacts[Global.available_artifacts.size() - 1]
				# Удалить последний элемент массива с помощью метода pop_back:
				Global.available_artifacts.pop_back()
				
				var artifact_instance = artifact_scene.instantiate()
				artifact_instance.position = position + Vector2(0, -16)
				get_parent().add_child(artifact_instance)
			
			
func _on_chest_zone_body_entered(body):
	if body.has_method("player"):
		player_nearby = true


func _on_chest_zone_body_exited(body):
	if body.has_method("player"):
		player_nearby = false
