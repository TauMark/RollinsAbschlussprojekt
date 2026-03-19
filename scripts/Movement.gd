extends CharacterBody2D

@export var speed = 400
@onready var sprite: AnimatedSprite2D = $Sprite
var dir = "res://Scenes/Rooms/"
var savedir = "res://data/"
var point_counter = 0

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	return input_direction

func _ready() -> void:
	var data = {}
	
	if FileAccess.file_exists(savedir + "playerdata.json"):
		var file_r = FileAccess.open(savedir + "playerdata.json", FileAccess.READ)
		data = JSON.parse_string(file_r.get_as_text())
		file_r.close()
		position = Vector2(data.x,data.y)
	

func _physics_process(delta):
	move_and_slide()
	

func _process(delta):
	var direction = get_input()
	handle_animation(direction)

func handle_animation(direction):
	if direction.x > 0:
		sprite.scale.x = -1
		sprite.play("walk")
	elif direction.x < 0:
		sprite.scale.x = 1
		sprite.play("walk")
	else :
		sprite.play("idle")
		
		
func _on_area_2d_area_entered(area: Area2D) -> void:
	pass
	
func _on_collecteble_pickup_area_entered(area: Area2D) -> void:
	if area.is_in_group("Point"):
		point_counter = getPoints()
		set_points(point_counter + 1)
		updatePoints()
		print(point_counter)

func updatePoints():
	var data = {}
	
	if FileAccess.file_exists(savedir + "playerdata.json"):
		var file_r = FileAccess.open(savedir + "playerdata.json", FileAccess.READ)
		data = JSON.parse_string(file_r.get_as_text())
		file_r.close()
		
		if typeof(data) != TYPE_DICTIONARY:
			data = {}
	
	data["point_counter"] = point_counter
	
	var file_w = FileAccess.open(savedir + "playerdata.json", FileAccess.WRITE)
	file_w.store_string(JSON.stringify(data, "\t"))
	file_w.close()
	
	
func getPoints() -> int:
	if not FileAccess.file_exists(savedir + "playerdata.json"):
		return 0
	
	var file = FileAccess.open(savedir + "playerdata.json", FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	file.close()
	
	if typeof(data) == TYPE_DICTIONARY and data.has("point_counter"):
		return int(data["point_counter"])
	
	return 0
	
		
		
func set_points(new_point_count: int) -> void:
	point_counter = new_point_count
