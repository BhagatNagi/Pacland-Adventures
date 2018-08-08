extends Node

onready var just_pressed = false

func _process(delta):
		just_pressed = true

func click():
	if just_pressed:
		$click.play()
		just_pressed = false

func move():
	if just_pressed:
		$move.play()
		just_pressed = false