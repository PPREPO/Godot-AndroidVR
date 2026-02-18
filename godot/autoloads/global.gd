extends Node

var debug:bool = true
var head_tilt:bool = true #for head tiling
var head_y_direction:int = -1 #for inverse or non-inverse direction
var head_x_direction:int = -1 # same with the upper one but for x-axis
var E_VR:bool = false #enable vr mode

func _input(event: InputEvent) -> void:
	if event is InputEvent:
		if Input.is_key_pressed(KEY_ESCAPE) and debug == true:
			get_tree().quit()
