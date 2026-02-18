extends Control

@onready var leftS:TextureRect = $left
@onready var RightS:TextureRect = $Right
@onready var Background:TextureRect = $Bg
@onready var CenteredButton:TouchScreenButton = $CenteredButton

var half_screen:Vector2
var distance:Vector2
var manipulated_variable:float=20

func _ready() -> void:
	Background.size = DisplayServer.screen_get_size()
	half_screen = DisplayServer.screen_get_size() / 2
	distance = half_screen / 2.18
	CenteredButton.position = Vector2(half_screen.x - 37,half_screen.y/14)
	
	leftS.set_position(Vector2(((half_screen.x)/1.8 - (distance.x)) + manipulated_variable, half_screen.y/28)) #i hates math bro dont ask why is so fucking longg
	RightS.set_position(Vector2(((half_screen.x)/1.8 + (distance.x)) + manipulated_variable, half_screen.y/28))
	match Global.E_VR:
		true:
			show()
		false:
			hide()
