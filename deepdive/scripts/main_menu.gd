extends Control
var inCredits = false
@onready var creditScreen = $creditBG
@onready var mainMenuButtons = $mainMenuButtons
@onready var optionsButtons = $optionsMenuButtons
@onready var demo_level: PackedScene = preload("res://scenes/lower_diver.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Handles main menu buttons
func _on_start_button_pressed() -> void:
	self.visible = false
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_packed(demo_level)

func _on_options_button_pressed() -> void:
	# TODO implement sound options and menu
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_credits_button_pressed() -> void:
	if inCredits:
		creditScreen.hide()
		mainMenuButtons.show()
	else:
		creditScreen.show()
		mainMenuButtons.hide()
	inCredits = !inCredits
