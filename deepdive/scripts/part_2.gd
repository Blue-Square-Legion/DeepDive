extends Area2D

func sonar_glow() -> void:
	$Sprite2D.material.set_shader_parameter("toggle_outline", true)
	await get_tree().create_timer(2.0).timeout
	$Sprite2D.material.set_shader_parameter("toggle_outline", false)
