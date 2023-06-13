extends Control


func _on_button_settings_back_pressed():
	hide()
	get_node("/root/Main/menu/MainMenu").show()
