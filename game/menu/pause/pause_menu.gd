extends Control

func _ready():
	hide()
	Global.connect("toggle_game_paused", on_game_toggle_game_paused)

func on_game_toggle_game_paused(is_paused: bool):
	if (is_paused):
		show()
	else:
		hide()


func _on_resume_button_pressed():
	Global.game_paused = false


func _on_exit_button_pressed():
	Global.game_paused = false
	
	for child in get_node("/root/Main/Game").get_children():
		child.queue_free()
		
	Global.reset_characteristics()
	
	get_node("/root/Main/Background").show()
	get_node("/root/Main/menu/MainMenu").show()
	Global.in_game = false


func _on_restart_button_pressed():
	Global.game_paused = false
	
	Global.reset_characteristics()
	
	for child in get_node("/root/Main/Game").get_children():
		child.queue_free()
	var level = load("res://game/levels/level1.tscn").instantiate()
	get_node("/root/Main/Game").add_child(level)
	
