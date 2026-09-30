extends Label

func _process(delta: float) -> void:
	text = "You got " + str(Gamemanager.score) + " scores"
