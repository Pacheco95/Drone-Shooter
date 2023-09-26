extends CharacterBody2D

var is_player_nearby := false
var can_laser := false
var spawn_position_index = 0

signal laser(pos, direction)

func _process(_delta):
	if is_player_nearby:
		look_at(Globals.player_position)

		if can_laser:
			shoot()


func shoot():
	var direction = (Globals.player_position - global_position).normalized()
	var laser_marker := $LaserSpawnPosition.get_children()[spawn_position_index]
	spawn_position_index = (spawn_position_index + 1) % $LaserSpawnPosition.get_child_count()
	laser.emit(laser_marker.global_position, direction)
	can_laser = false
	$LaserCooldown.start()


func _on_attack_area_body_exited(_body: Node2D):
	is_player_nearby = false

func _on_attack_area_body_entered(_body: Node2D):
	is_player_nearby = true


func _on_laser_cooldown_timeout():
	can_laser = true
