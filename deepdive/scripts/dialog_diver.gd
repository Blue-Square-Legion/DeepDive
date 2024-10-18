extends Node2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var demo_level: PackedScene = preload("res://scenes/main.tscn")

const lines: Array[String] = [
	"Greetings Diver!",
	"Your mission is to repair a malfunctioning device on the sea floor.",
	"To do this you will need to find the parts we dropped my mistake...",
	"They will likely be hidden underneath the sand.",
	"You have a sonar device to help you find them. (E KEY)",
	"You will only be able to carry one part at a time, so make sure you get the right one!",
	"You will be able to pick up the parts when they are visible with (SPACEBAR)",
	"Good Luck Diver!, and work quickly!",
	"If you stay under too long we will have to abandon the mission.",
]


func _ready() -> void:
	DialogManager.end_messages.connect(_on_end_messages)
	await get_tree().create_timer(1.0).timeout
	DialogManager.start_dialog(sprite_2d.global_position, lines)

func _on_end_messages():
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_packed(demo_level)
