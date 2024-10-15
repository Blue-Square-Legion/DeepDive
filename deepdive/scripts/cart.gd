extends Area2D

@onready var machine_ui: CanvasLayer = %MachineUI
@onready var holy_diver: Player = %HolyDiver

var canEnter: bool = false
var inRange: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	machine_ui.connect("machine_fixed", _on_machine_fixed)

func _on_machine_fixed():
	canEnter = true

func _process(delta: float) -> void:
	if inRange && canEnter:
		if Input.is_action_just_pressed("part_interaction"):
			get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

# Detects if the player has entered or range of the cart
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print_debug("player entered")
		inRange = true
		if canEnter:
			holy_diver.update_label("Congrats!! Press Space!")

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		print_debug("player left")
		inRange = false
		if canEnter:
			holy_diver.update_label("")
