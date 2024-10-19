extends Node2D

@onready var animation_tree: AnimationTree = $"../AnimationTree"
@onready var holy_diver: Player = get_owner()

var last_facing_direction := Vector2(0, -1)

func _physics_process(delta: float) -> void:
	var idle = !holy_diver.velocity
	if !idle:
		last_facing_direction = holy_diver.velocity.normalized()
	
	animation_tree.set("parameters/AnimationNodeStateMachine/Idle/blend_position", last_facing_direction)
	animation_tree.set("parameters/AnimationNodeStateMachine/walking/blend_position", last_facing_direction)
