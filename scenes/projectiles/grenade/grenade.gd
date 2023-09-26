extends RigidBody2D

const speed = 750
@export var explosion_radius: = 300

var is_exploding = false

func _process(delta):
	if is_exploding:
		apply_damage()


func apply_damage():
	for entity in get_tree().get_nodes_in_group("Destroyable"):
		if "hit" not in entity:
			continue
		
		var distance = entity.global_position.distance_to(global_position)

		if distance <= explosion_radius:
			entity.hit()

func explode():
	is_exploding = true
	$AnimationPlayer.play("Explode")
