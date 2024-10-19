class_name Player extends CharacterBody2D

var picked_up_part: PackedScene = null
var is_holding_part: bool = false
var able_to_move: bool = true
var in_part_area: Area2D = null

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var in_game_hud: CanvasLayer = %InGameHud
@onready var main: Node = $".."
@onready var label: Label = %Label

signal set_part_texture(part: Area2D)
signal set_drop_part

var speed := 300.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	in_game_hud.connect("clear_part_array", _on_clear_array)
	main.connect("on_machine_ui_open", _on_machine_ui_open)
	main.connect("on_machine_ui_close", _on_machine_ui_close)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down") 
	if direction:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
	
	if able_to_move:
		move_and_slide()
	
	if Input.is_action_just_pressed("sonar"):
		trigger_sonar()
	
	handle_part_pickup()
	
func _on_clear_array():
	in_part_area = null
	is_holding_part = false
	
## HANDLE THE LABEL TEXT ##
func update_label(newText:String):
	label.text = newText

## HANDLE ITEM PICK UP ##
func pick_up(part: Area2D):
	if is_holding_part:
		return
	picked_up_part = PackedScene.new()
	picked_up_part.pack(part)
	emit_signal("set_part_texture", part)
	
	part.queue_free() # removes from scene
	is_holding_part = true

func drop_part():
	if picked_up_part and is_holding_part:
		var new_sprite_instance = picked_up_part.instantiate()
		new_sprite_instance.position = self.position
		get_parent().add_child(new_sprite_instance)
		new_sprite_instance.setup()
		emit_signal("set_drop_part")
		picked_up_part = null
		is_holding_part = false

func _on_part_detection_area_entered(part: Area2D) -> void:
	if part.is_in_group("part"):
		in_part_area = part
		print("seen part " + part.name)

func _on_part_detection_area_exited(part: Area2D) -> void:
	if part.is_in_group("part"):
		in_part_area = null
		print("left part")
		part.left_part()
		
func handle_part_pickup():
	if Input.is_action_just_pressed("part_interaction"):
		
		if in_part_area == null && is_holding_part == true:
			drop_part()
			return
		
		if in_part_area != null:
			if in_part_area.can_be_picked == false && is_holding_part != true:
				return
			pick_up(in_part_area)
			is_holding_part = true

		
## HANDLE SONAR ##
var active_areas = []

func trigger_sonar():
	$Sprite2D.visible = not $Sprite2D.visible
	await get_tree().create_timer(0.2).timeout
	$Sprite2D.visible = not $Sprite2D.visible
	#animation_player.play("sonar_animation")
	for part in active_areas:
		part.sonar_glow()
		
func _on_sonar_area_entered(area: Area2D) -> void:
	if area is Area2D:
		if area.is_in_group("part"):
			active_areas.push_back(area)

func _on_sonar_area_exited(area: Area2D) -> void:
	if area is Area2D:
		active_areas.erase(area)

func _on_machine_ui_close():
	able_to_move = true
	
func _on_machine_ui_open():
	able_to_move = false
