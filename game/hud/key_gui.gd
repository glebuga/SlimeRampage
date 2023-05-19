extends Panel


func _ready():
	$quantity.text = str(Global.Key_Player)
	for node in get_tree().get_nodes_in_group("key"):
		node.refresh_key.connect(_on_key_refresh_key)
	for node in get_tree().get_nodes_in_group("chest"):
		node.refresh_key.connect(_on_chest_refresh_key)
	
	
func refresh_key():
	$quantity.text = str(Global.Key_Player)
	
	
func _on_key_refresh_key():
	refresh_key()


func _on_chest_refresh_key():
	refresh_key()
