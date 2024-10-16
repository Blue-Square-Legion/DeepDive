extends CanvasLayer

@onready var main: Node = $".."

@onready var a: TextureRect = %a
@onready var w: TextureRect = %w
@onready var s: TextureRect = %s
@onready var d: TextureRect = %d

@onready var puzzleArray: Array[TextureRect] = []

@onready var have_a_part_text: Label = %HaveAPartText
@onready var puzzle_control: HBoxContainer = %PuzzleControl

@onready var part_1: TextureRect = %Part_1
@onready var part_2: TextureRect = %Part_2

@onready var parts:Array[TextureRect] = [part_1, part_2]

@onready var close: Button = %Close

signal on_close()
signal on_success()
signal machine_fixed()

## TODO create a way to get the part in the players inventory and match with what is required.
var my_part:String = ""
var machine_ui: bool = false

## TODO use _input to try to give feedback if the player hit the wrong button, and reset the progress.

func _ready() -> void:
	setup()
	
	part_1.material.set_shader_parameter("toggle_silouette", true)
	part_2.material.set_shader_parameter("toggle_silouette", true)
	
	main.connect("has_part", _on_has_part)
	main.connect("remove_part", _on_remove_part)
	main.connect("on_machine_ui_open", _on_machine_ui_open)
	main.connect("on_machine_ui_close", _on_machine_ui_close)

func setup():
	have_a_part_text.visible = false
	have_a_part_text.text = ""
	puzzle_control.visible = false
	
	## TODO we cannot make these random yet, we need will need to make the texturerect a scene and generate it.
	if !puzzleArray.is_empty():
		puzzleArray.clear()
	puzzleArray = [a, w, s, d]
	
	for i in puzzleArray:
		i.modulate = Color.WHITE

func _process(delta: float) -> void:
	puzzle(enable_puzzle())
	if parts.is_empty():
		machine_fixed.emit()

func enable_puzzle() -> TextureRect:
	for part in parts:
		if my_part != null:
			if my_part == part.name:
				have_a_part_text.visible = true
				have_a_part_text.text = "You have " + part.name + "! Enter the correct keys to install it!"
				puzzle_control.visible = true
				return part
	return null

func puzzle(part: TextureRect):
	if machine_ui == true:
		if part != null:
			if !puzzleArray.is_empty():
				## Add a timer to reset progress if player is too slow.
				var item = puzzleArray[0]
				if Input.is_action_just_pressed(item.name):
					item.modulate = Color.GREEN
					puzzleArray.erase(item)
			else:
				have_a_part_text.text = "Success!"
				on_success.emit()
				part.material.set_shader_parameter("toggle_silouette", false)
				parts.erase(part)
			
func _on_has_part(part: TextureRect):
	## TODO need to get the correct part in a different way, if someone renames the file it will break this.
	my_part = part.texture.resource_path.get_file().get_basename()
	 

func _on_remove_part():
	my_part = ""
			
func _on_close_pressed() -> void:
	setup()
	on_close.emit()
	
func _on_machine_ui_open():
	machine_ui = true

func _on_machine_ui_close():
	machine_ui = false
