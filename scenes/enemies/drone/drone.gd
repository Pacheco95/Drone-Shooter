extends CharacterBody2D

var active := false

@export var min_speed := 400
@export var speed_step := 100

@onready var speed := min_speed
var hp = 20
var exploding := false

@export var explosion_radius := 300

func _ready():
	$Explosion.hide()

func _process(delta):
	if exploding:
		apply_damage()

	if hp <= 0:
		explode()
		return

	var speed_signal = 1 if active else 0
	speed += speed_signal * speed_step * delta
		
	if not active:
		return

	look_at(Globals.player_position)
	var direction = (Globals.player_position - position).normalized()
	velocity = direction * speed * delta

	if move_and_collide(velocity):
		hp = 0
		hit()

func hit():
	hp -= 10
	create_tween().tween_property($Sprite2D.material, "shader_parameter/brightnes", 0.0, 0.3).from(0.5)

func _on_notice_area_body_entered(_body: Node2D):
	active = true

func explode():
	exploding = true
	$Explosion.show()
	$AnimationPlayer.play("explosion")

func apply_damage():
	for entity in get_tree().get_nodes_in_group("Destroyable"):
		if "hit" not in entity:
			continue
		
		var distance = entity.global_position.distance_to(global_position)

		if distance <= explosion_radius:
			entity.hit()
