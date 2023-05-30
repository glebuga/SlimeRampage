extends Node

# Сигнал для отображения паузы
signal toggle_game_paused(is_paused : bool)

# Переменная для вызова сигнала паузы(get и set)
var game_paused : bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		emit_signal("toggle_game_paused", game_paused)

var Damage_Enemy = 1 #Урон врага

var Max_Health_Player: int = 3 # Максимальное здоровье персонажа
var Сurrent_Health_Player: int = Max_Health_Player # Текущее здоровье персонажа
var Fire_Rate_Player: float = 1.0 # Скорострельность персонажа
var Speed_Player: float = 100.0 # Скорость персонажа
var Damage_Player = 1 #Урон персонажа
var Key_Player: int = 10 #кол-во ключей персонажа

var artifacts = []
var available_artifacts = []

var inventory = []

func _ready():
	var dir = DirAccess.open("res://game/artifacts")
	if dir != null:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".tscn"):
				var artifact = load("res://game/artifacts/" + file_name)
				artifacts.append(artifact)
			file_name = dir.get_next()
	available_artifacts = artifacts.duplicate()

func _input(event: InputEvent):
	if(event.is_action_pressed("esc")):
		game_paused = !game_paused
