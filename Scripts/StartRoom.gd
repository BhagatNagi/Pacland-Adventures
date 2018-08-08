extends Node2D

onready var skip = false

func _ready():
	GLOBAL.playing = false
	$HUD.hide()

func _input(event):
	if event.is_action_type() and skip and $Intro.visible:
		$Intro.hide()
		SOUND.click()
		GLOBAL.playing = true
		$HUD.show()


func _on_intro_timeout():
	skip = true

