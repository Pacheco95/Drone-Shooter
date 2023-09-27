extends CharacterBody2D

var active := false

@export var speed := 300

var is_vulnerable := true
var is_player_near := false
var health = 30

func _process(_delta):
	if not active:
		return

	var direction = (Globals.player_position - position).normalized()
	velocity = direction * speed
	look_at(Globals.player_position)
	
	if not is_player_near:
		move_and_slide()

func hit():
	if not is_vulnerable:
		return
	
	is_vulnerable = false
	$Timers/HitTimer.start()
	create_tween().tween_property($AnimatedSprite2D.material, "shader_parameter/brightnes", 0, 0.3).from(0.5)
	$Particles/HitParticles.emitting = true

	health -= 10

	if health <= 0:
		var tween := create_tween()
		tween.tween_property(self, "modulate:a", 0, 0.3)
		tween.tween_callback(queue_free)


func _on_attack_area_body_entered(_body: Node2D):
	is_player_near = true
	$AnimatedSprite2D.play("attack")


func _on_attack_area_body_exited(_body: Node2D):
	is_player_near = false
	$AnimatedSprite2D.play("walk")
	

func _on_notice_area_body_entered(_body: Node2D):
	active = true
	$AnimatedSprite2D.play("walk")


func _on_notice_area_body_exited(_body: Node2D):
	active = false
	$AnimatedSprite2D.stop()



func _on_animated_sprite_2d_animation_finished():
	if not is_player_near:
		return

	Globals.hp_amount = max(Globals.hp_amount - 10, 0)
	$Timers/AttackTimer.start()



func _on_hit_timer_timeout():
	is_vulnerable = true

func _on_attack_timer_timeout():
	$AnimatedSprite2D.play("attack")
