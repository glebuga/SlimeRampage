extends Control



func _on_button_quit_pressed():
	get_tree().quit()


func _on_button_settings_pressed():
	get_node("/root/Main/menu/SettingsMenu").show()
	hide()

func _on_button_play_pressed():
	var level = load("res://game/levels/level1.tscn").instantiate()
	get_node("/root/Main/Game").add_child(level)
	get_node("/root/Main/Background").hide()
	hide()
	Global.in_game = true
