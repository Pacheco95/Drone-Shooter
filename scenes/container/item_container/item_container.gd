extends StaticBody2D
class_name ItemContainer

signal open(pos, current_direction)

var opened := false

@onready var current_direction := Vector2.DOWN.rotated(rotation)

func hit():
	if opened:
		return false
	
	opened = true

	$LidSprite.hide()
	
	return true
