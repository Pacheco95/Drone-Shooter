extends PathFollow2D

@export var speed := 500
@export var angular_velocity := 0.5

@export var active := false
@export var can_cancel_shoot_animation := false
@export var keep_look_to_player := false

@onready var left_ray: RayCast2D = $Turret/LeftRayCast
@onready var right_ray: RayCast2D = $Turret/RightRayCast

@onready var left_laser: Line2D = $Turret/LeftRayCast/LeftLaser
@onready var right_laser: Line2D = $Turret/RightRayCast/RightLaser


func _process(delta):
	progress += delta * speed

	rotate_turret()

	var has_collided := left_ray.get_collider() and right_ray.get_collider()

	if has_collided:
		on_collision_detected()
	else:
		if can_cancel_shoot_animation:
			$AnimationPlayer.stop()

func on_collision_detected():
	left_laser.points[1].y = left_ray.get_collision_point().distance_to(left_laser.global_position)
	right_laser.points[1].y = right_ray.get_collision_point().distance_to(right_laser.global_position)
	
	if not $AnimationPlayer.is_playing():
		$AnimationPlayer.play("shoot")

func shoot():
	Globals.hp_amount -= 30

func rotate_turret():
	var angle_to_player = $Turret.get_angle_to(Globals.player_global_position)
	var target_angle = $Turret.rotation + angle_to_player if (active or keep_look_to_player) else 0
	create_tween().tween_property($Turret, "rotation", target_angle, angular_velocity)

func _on_area_2d_body_entered(_body: Node2D):
	active = true

func _on_area_2d_body_exited(_body: Node2D):
	active = false

