extends CharacterBody2D

const Utils = preload("res://scripts/utils.gd")

signal player_shot_laser(pos, direction)
signal player_threw_grenade(pos, direction)

@export var max_velocity := 600
@export var movement_velocity := 600
@export var deadzone := 0.1

var can_laser: bool = true
var can_grenade: bool = true

func _ready():
	Globals.player_position = position

func _process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * movement_velocity
	move_and_slide()
	Globals.player_position = global_position

	look_at(get_global_mouse_position())

	# if direction.length() > deadzone:
		# rotation_degrees = rad_to_deg(direction.angle()) + 90
	
	var player_direction := (get_global_mouse_position() - position).normalized()
	var laser_markers = $LaserStartPositions.get_children()
	var laser_marker = Utils.pick_random(laser_markers)

	if Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		player_shot_laser.emit(laser_marker.global_position, player_direction)
		$LaserCooldown.start()
		can_laser = false
	
	if Input.is_action_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0:
		Globals.grenade_amount -= 1
		player_threw_grenade.emit(laser_marker.global_position, player_direction)
		$GrenadeCooldown.start()
		can_grenade = false

func hit():
	Globals.hp_amount -= 1

func _on_laser_cooldown_timeout():
	can_laser = true


func _on_grenade_cooldown_timeout():
	can_grenade = true
