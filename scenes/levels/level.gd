extends Node2D

const laser_scene := preload("res://scenes/projectiles/laser/laser.tscn")
const grenade_scene := preload("res://scenes/projectiles/grenade/grenade.tscn")

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


func _on_player_player_threw_grenade(pos, direction):
	var grenade := grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)


func _on_player_player_shot_laser(pos, direction):
	var laser = laser_scene.instantiate()
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	laser.direction = direction
	$Projectiles.add_child(laser)
