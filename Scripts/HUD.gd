extends CanvasLayer

# HUD variables
var visible

# Dialogue variables
var delivering
var dind

# Pause menu variables
var category # Either berries or options
var ind

func _ready():
	visible = true
	delivering = false
	dind = 0
	category = 0
	ind = 0
	
	# Pause menu hiding
	$PauseBG.frame = 0
	$PauseMenu.hide()

func _process(delta):
	
	$HealthBar.value = GLOBAL.health
	
	
	if GLOBAL.dialogues.size() > 0 and visible:
		
		if not delivering:
			
			delivering = true
			GLOBAL.playing = false
			$Dialogues/Label.text = GLOBAL.dialogues[0]
			$Dialogues.show()
	else:
		
		$Dialogues.hide()
		delivering = false
		GLOBAL.playing = true

func _input(event):
	
	if event.is_action_released("ui_accept"):
		if delivering:
			update_dialogue()
		elif get_tree().paused:
			pass ## Pause Menu Code here ##
	
	if event.is_action_released("ui_pause") and visible:
		
		if not get_tree().paused:
			get_tree().paused = true
			$PauseBG.play("On")
			yield($PauseBG, "animation_finished")
			$PauseMenu.show()
		else:
			get_tree().paused = false
			$PauseMenu.hide()
			$PauseBG.play("Off")
	
	if get_tree().paused and event.is_action_type():
		pause_menu()


func hide():
	visible = false
	for child in self.get_children():
		child.hide()

func show():
	visible = true
	for child in self.get_children():
		if child.name != "PauseMenu": child.show()

func update_dialogue():
	if dind < GLOBAL.dialogues.size() - 1:
		dind += 1
		$Dialogues/Label.text = GLOBAL.dialogues[dind]
	else:
		dind = 0
		GLOBAL.dialogues = []

func pause_menu():
	
	if Input.is_action_just_pressed("ui_up"):
		ind -= 1
	elif Input.is_action_just_pressed("ui_down"):
		ind += 1
	
	if Input.is_action_just_pressed("ui_left"):
		category -= 1
		ind = 0
	elif Input.is_action_just_pressed("ui_right"):
		category += 1
	
	category = clamp(category, 0, 1)
	
	if category == 0:
		ind = clamp(ind, 0, $PauseMenu/Berries/List.get_child_count() - 1)
	elif category == 1:
		ind = clamp(ind, 0, 2)
	
	scroll_n_name()
	
	cur_pos()

func cur_pos():
	if category == 0:
		$PauseMenu/OptionFlag.hide()
		$PauseMenu/EatFlag.show()
		
		$PauseMenu/EatFlag.rect_position.y = $PauseMenu/Berries.rect_position.y - $PauseMenu/Berries.scroll_vertical + ind * 20
		
	elif category == 1:
		$PauseMenu/OptionFlag.show()
		$PauseMenu/EatFlag.hide()
		
		$PauseMenu/OptionFlag.rect_position.y = $PauseMenu/Option1.rect_position.y + (ind * 24)

func scroll_n_name():
	if category == 0:
		$PauseMenu/Berries.scroll_vertical = ind * 18
		$PauseMenu/BerryName.text = str($PauseMenu/Berries/List.get_child(ind).use)
	else:
		$PauseMenu/BerryName.text = ""

