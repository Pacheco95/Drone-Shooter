extends Node

signal hp_changed
signal laser_changed
signal grenade_changed

const max_laser_amount := 20
const max_grenade_amount := 5
const max_hp_amount := 100

var laser_amount := max_laser_amount:
	set(value):
		laser_amount = value
		laser_changed.emit()

var grenade_amount := max_grenade_amount:
	set(value):
		grenade_amount = value
		grenade_changed.emit()

var hp_amount := 0:
	set(value):
		hp_amount = value
		hp_changed.emit()
