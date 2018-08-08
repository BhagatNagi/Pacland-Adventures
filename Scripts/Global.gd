extends Node

# Main Menu variables
onready var screen = 0

# Player variables
onready var playing = false
onready var health = 100

# HUD variables
onready var dialogues = []

func _process(delta):
	health = clamp(health, 0, 100) # Code may be added in the future to increase max health

func init():
	screen = 0
	health = 100

func change_scene(scene):
	
	var path = "res://Scenes/" + scene + ".tscn"
	
	get_tree().change_scene(path)

func new_game():
	init()
	change_scene("StartRoom")
