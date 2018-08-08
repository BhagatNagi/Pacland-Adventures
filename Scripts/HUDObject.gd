extends TextureRect

export (String) var use = "Berry"
export (int) var value = 0

func _input(event):
	$Value.text = str(value)