class_name Player extends CharacterBody2D

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
	
var active_areas = []

func trigger_sonar():
	$Sprite2D.visible = not $Sprite2D.visible
	await get_tree().create_timer(0.2).timeout
	$Sprite2D.visible = not $Sprite2D.visible
	for part in active_areas:
		part.sonar_glow()

func _on_sonar_area_entered(area: Area2D) -> void:
	if area is Area2D:
		active_areas.push_back(area)

func _on_sonar_area_exited(area: Area2D) -> void:
	if area is Area2D:
		var index = active_areas.find(area)
		if index != -1:
			active_areas.remove_at(index)
