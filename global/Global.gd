extends Node


signal toggle_game_paused(is_paused : bool) # Сигнал для отображения паузы

# Сигналы для обновления gui контейнера сердец
signal taking_away_health_gui # Сигнал для обновления здоровья персонажа, когда он получает урон
signal adding_health_gui # Сигнал для обновления здоровья персонажа, когда он подбирает сердце
signal increasing_max_health_gui(diff) # Сигнал для увеличения максимального здоровья персонажа при подборе артефакта

signal refresh_key_gui(diff) # Сигнал для обновления количества ключей в gui

# Переменная для вызова сигнала паузы(get и set)
var game_paused : bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		emit_signal("toggle_game_paused", game_paused)

var Damage_Enemy = 1 #Урон врага

# Стандартные характеристики персонажа(переменные для того чтобы задать стандартные характеристики персонажу, если игра перезапущена)
var Standart_Health_Player: int = 3 # Здоровье персонажа
var Standart_Fire_Rate_Player: float = 1.0 # Скорострельность персонажа
var Standart_Speed_Player: float = 250.0 # Скорость персонажа
var Standart_Damage_Player = 1 # Урон персонажа
var Standart_Key_Player: int = 10 # Кол-во ключей персонажа


# Характеристики персонажа во время игры
var Max_Health_Player: int = Standart_Health_Player: # Максимальное здоровье персонажа
	get:
		return Max_Health_Player
	set(value):
		var diff = value - Max_Health_Player
		emit_signal("increasing_max_health_gui", diff)
		Max_Health_Player = value
var Сurrent_Health_Player: int = Max_Health_Player: # Текущее здоровье персонажа
	get:
		return Сurrent_Health_Player
	set(value):
		if value > Сurrent_Health_Player and not from_artifact:
			emit_signal("adding_health_gui")
		elif value < Сurrent_Health_Player:
			emit_signal("taking_away_health_gui")
		Сurrent_Health_Player = value
var Fire_Rate_Player: float = Standart_Fire_Rate_Player # Скорострельность персонажа
var Speed_Player: float = Standart_Speed_Player # Скорость персонажа
var Damage_Player = Standart_Damage_Player # Урон персонажа
var Key_Player: int = Standart_Key_Player: # Кол-во ключей персонажа
	get:
		return Key_Player
	set(value):
		emit_signal("refresh_key_gui", value) # Вызов сигнала обновления значения ключа в gui
		Key_Player = value


var artifacts = [] # Массив артефактов
var available_artifacts = [] # Массив доступных артефактов
var from_artifact = false # Переменная предназначенная для проверки: прибавка к текущему здоровью осуществляется с помощью подбора артефакта или нет

var inventory = [] # Массив для хранения действующих артефактах на герое


func _ready():
	adding_artifacts_to_an_array()


func _input(event: InputEvent):
	if(event.is_action_pressed("esc")):
		game_paused = !game_paused


# Добавление артефактов в массив
func adding_artifacts_to_an_array():
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
