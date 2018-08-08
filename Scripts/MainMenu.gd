extends CanvasLayer

const BLUE = Color(0, 0, 1, 1)
const WHITE = Color(1, 1, 1, 1)

var cur_pos
var ind

onready var GOMessages = ["Don't worry!\n It's not over yet...",
 "Well... better luck next time",
 "Oh well! My grandma plays\n better than you",
 "You didn't eat your berries\n did ya?",
 "Mind you, these messages are\n no fortune cookies",
"Ah well..."]
onready var GOEndline = "\n\nPress any key to continue"
onready var just_pressed = false # to fix double input

# In-built functions:
func _ready():
	cur_pos = $Start/Cursor.rect_position
	ind = 0
	update()

func _input(event):
	if event.is_action_type():
		
		if GLOBAL.screen == 0:
			
			start_screen()
			just_pressed = true
			
		elif not just_pressed:
			
			GLOBAL.screen = 0
			update()
			SOUND.click()
			
		else:
			
			just_pressed = false


# User defined functions:
func hide_all():
	$Start.hide()
	$About.hide()
	$GameOver.hide()

func update():
	hide_all()
	match(GLOBAL.screen):
		0:
			$Start.show()
			text_color()
		1:
			$About.show()
		2:
			$GameOver.show()
			go_message()

func go_message():
	randomize()
	var message = GOMessages[randi()%GOMessages.size()]
	$GameOver/Message.text = message + GOEndline

func start_screen():
	if Input.is_action_just_pressed("ui_accept"):
		start()
	else:
		move_cursor()
		mascot()

func move_cursor():
	if Input.is_action_just_pressed("ui_up"):
		ind -= 1
		SOUND.move()
	elif Input.is_action_just_pressed("ui_down"):
		ind += 1
		SOUND.move()
	
	if ind > 2:
		ind = 0
	elif ind < 0:
		ind = 2
	
	text_color()
	$Start/Cursor.rect_position.y = cur_pos.y + (ind * 16)

func start():
	SOUND.click()
	match(ind):
		0:
			GLOBAL.new_game()
		1:
			GLOBAL.screen = 1
			update()
		2:
			get_tree().quit()

func reset_color():
	$Start/Start.add_color_override("font_color", BLUE)
	$Start/About.add_color_override("font_color", BLUE)
	$Start/Quit.add_color_override("font_color", BLUE)

func text_color():
	
	reset_color()
	
	match(ind):
		0:
			$Start/Start.add_color_override("font_color", WHITE)
		1:
			$Start/About.add_color_override("font_color", WHITE)
		2:
			$Start/Quit.add_color_override("font_color", WHITE)

func mascot():
	# Hiding all mascots
	for child in $Start/Mascot.get_children():
		child.hide()
	match(ind):
		0:
			$Start/Mascot/Start.show()
		1:
			$Start/Mascot/About.show()
		2:
			$Start/Mascot/Quit.show()

