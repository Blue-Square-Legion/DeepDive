extends Area2D

var can_be_picked: bool = false

func sonar_glow() -> void:
	$Sprite2D.material.set_shader_parameter("toggle_outline", true)
	can_be_picked = not can_be_picked
	await get_tree().create_timer(2.0).timeout
	$Sprite2D.material.set_shader_parameter("toggle_outline", false)
	can_be_picked = not can_be_picked
