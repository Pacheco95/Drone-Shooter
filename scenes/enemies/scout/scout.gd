extends CharacterBody2D

var is_player_nearby := false
var can_laser := false
var spawn_position_index = 0

@export var max_health := 300
var health := max_health

var vulnerable = true

signal laser(pos, direction)

func _process(_delta):
	if is_player_nearby:
		look_at(Globals.player_global_position)

		if can_laser:
			shoot()

func hit():
	if not vulnerable:
		return
	
	create_tween().tween_property($Sprite2D.material, "shader_parameter/brightnes", 0, 0.3).from(0.5)

	health -= 10

	if health <= 0:
		die()

func die():
	queue_free()

func shoot():
	var direction = (Globals.player_global_position - global_position).normalized()
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


func _on_invinerable_timer_timeout():
	vulnerable = not vulnerable
