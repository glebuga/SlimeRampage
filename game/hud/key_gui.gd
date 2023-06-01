extends Panel


func _ready():
	$quantity.text = str(Global.Key_Player)
	Global.refresh_key_gui.connect(refresh_key)
	
func refresh_key(diff):
	$quantity.text = str(diff)
	
