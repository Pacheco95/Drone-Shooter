extends CanvasLayer


func change_scene(scene: PackedScene):
	$AnimationPlayer.play("fade_to_black")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_packed(scene)
	$AnimationPlayer.play_backwards("fade_to_black")
