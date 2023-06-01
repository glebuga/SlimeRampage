extends Node2D

signal refresh_key


func _ready():
	pass


# Обработка сигнала, когда что-то поподает в коллизию ключа
func _on_area_2d_body_entered(body):
	# проверка, является ли это игрок
	if body.has_method("player"):
		Global.Key_Player += 1 # Прибавляем кол-во ключей
		queue_free() # Удаляем ключ со сцены

	
