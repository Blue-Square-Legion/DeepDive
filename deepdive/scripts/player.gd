class_name Player extends CharacterBody2D

var picked_up_part: PackedScene = null
var is_holding_part: bool = false

signal set_part_texture(part: Area2D)
signal set_drop_part

var speed := 120.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down") 
	if direction:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()
	
	if Input.is_action_just_pressed("sonar"):
		trigger_sonar()
		
	handle_part_pickup()
	

## HANDLE ITEM PICK UP ##
func pick_up(part: Area2D):
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
		emit_signal("set_drop_part")
		is_holding_part = false

var active_parts = []

func _on_part_detection_area_entered(part: Area2D) -> void:
	print("seen part " + part.name)
	if part.can_be_picked == true && is_holding_part != true:
		active_parts.push_back(part)

### TODO there is a bug here come back later to find a better way to handle it.
#func clean_part():
	#if active_parts.size() > 0:
		#await get_tree().create_timer(0.2).timeout
		#active_parts.remove_at(0)
		
func handle_part_pickup():
	if Input.is_action_just_pressed("part_interaction"):
		if active_parts.size() > 0:
			is_holding_part = true
			for part in active_parts:
				pick_up(part)
				var index = active_parts.find(part)
				if index != -1:
					active_parts.remove_at(index)
		elif is_holding_part == true:
			drop_part()
		
	
## HANDLE SONAR ##
var active_areas = []

func trigger_sonar():
	$Sprite2D.visible = not $Sprite2D.visible
	await get_tree().create_timer(0.2).timeout
	$Sprite2D.visible = not $Sprite2D.visible
	for part in active_areas:
		part.sonar_glow()

func _on_sonar_area_entered(area: Area2D) -> void:
	if area is Area2D:
		if area.is_in_group("part"):
			active_areas.push_back(area)

func _on_sonar_area_exited(area: Area2D) -> void:
	if area is Area2D:
		var index = active_areas.find(area)
		if index != -1:
			active_areas.remove_at(index)
