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
	get_tree().quit()
