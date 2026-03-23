extends CharacterBody2D
 
@export var speed = 400
@onready var sprite: AnimatedSprite2D = $Sprite
var dir     = "res://Scenes/Rooms/"
var savedir = "res://data/"
var point_counter = 0
 
# ── Input & Bewegung ──────────────────────────────────────────────────────────
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	return input_direction
 
func _ready() -> void:
	if FileAccess.file_exists(savedir + "playerdata.json"):
		var file_r = FileAccess.open(savedir + "playerdata.json", FileAccess.READ)
		var data = JSON.parse_string(file_r.get_as_text())
		file_r.close()
		if typeof(data) == TYPE_DICTIONARY:
			position = Vector2(data.get("x", 0.0), data.get("y", 0.0))
			point_counter = int(data.get("point_counter", 0))
 
func _physics_process(_delta):
	move_and_slide()
 
func _process(_delta):
	var direction = get_input()
	handle_animation(direction)
 
func handle_animation(direction):
	if direction.x > 0:
		sprite.scale.x = -1
		sprite.play("walk")
	elif direction.x < 0:
		sprite.scale.x = 1
		sprite.play("walk")
	else:
		sprite.play("idle")
 
# ── Punkte ────────────────────────────────────────────────────────────────────
 
## Fügt `amount` Punkte hinzu und speichert sofort.
func add_points(amount: int) -> void:
	point_counter += amount
	_save_points()
	print("Punkte: ", point_counter)
 
## Alias, der vom Collectible-System aufgerufen wird (1 Punkt).
func _on_collecteble_pickup_area_entered(area: Area2D) -> void:
	if area.is_in_group("Point"):
		add_points(1)
 
func _on_area_2d_area_entered(_area: Area2D) -> void:
	pass
 
# ── Persistenz ────────────────────────────────────────────────────────────────
func _save_points() -> void:
	var data = {}
	if FileAccess.file_exists(savedir + "playerdata.json"):
		var file_r = FileAccess.open(savedir + "playerdata.json", FileAccess.READ)
		var parsed = JSON.parse_string(file_r.get_as_text())
		file_r.close()
		if typeof(parsed) == TYPE_DICTIONARY:
			data = parsed
 
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
