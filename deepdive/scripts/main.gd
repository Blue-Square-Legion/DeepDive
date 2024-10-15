extends Node

@onready var machine_ui: CanvasLayer = %MachineUI
@onready var in_game_hud: CanvasLayer = %InGameHud
@onready var holy_diver: Player = %HolyDiver

var can_fix_machine: bool = false

var part:TextureRect = null

signal has_part(part:TextureRect)
signal remove_part()
signal on_machine_ui_open()
signal on_machine_ui_close()

func _ready() -> void:
	machine_ui.visible = false
	machine_ui.connect("on_close", _on_close_event)
	in_game_hud.connect("current_part", _on_current_part)
	in_game_hud.connect("remove_part", _on_remove_part)
	
	
func _process(delta: float) -> void:
	if can_fix_machine == true:
		if Input.is_action_just_pressed("sonar"):
			on_machine_ui_open.emit()
			machine_ui.visible = not machine_ui.visible

func _on_machine_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		holy_diver.update_label("Press E.")
		can_fix_machine = true

func _on_machine_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		holy_diver.update_label("")
		can_fix_machine = false

func _on_close_event():
	on_machine_ui_close.emit()
	machine_ui.visible = false
	
func _on_current_part(incoming_part: TextureRect):
	part = incoming_part
	has_part.emit(part)

func _on_remove_part():
	remove_part.emit()
	part = null
