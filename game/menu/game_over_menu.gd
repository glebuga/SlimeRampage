extends Control



func _on_button_restart_pressed():
	Global.game_paused = false
	
	Global.reset_characteristics()
	
	for child in get_node("/root/Main/Game").get_children():
		child.queue_free()
	var level = load("res://game/levels/level1.tscn").instantiate()
	get_node("/root/Main/Game").add_child(level)


func _on_button_back_menu_pressed():
	hide()
	get_node("/root/Main/menu/MainMenu").show()


func _on_button_quit_pressed():
	get_tree().quit()
