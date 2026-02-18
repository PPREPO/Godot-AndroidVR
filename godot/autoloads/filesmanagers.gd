extends Node

func config_Saves(DATA:Dictionary) -> void:
	var saves:FileAccess = FileAccess.open("res://config.cfg", FileAccess.WRITE)
	saves.store_var(var_to_str(DATA.get("head_tilt")))
	
func config_Loads():
	var data:FileAccess = FileAccess.open("res://config.cfg", FileAccess.READ)
	var contents:Dictionary = data.get_var()
	return contents
