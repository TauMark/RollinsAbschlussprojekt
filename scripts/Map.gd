extends Node

@export var starting_room: String = "res://Scenes/Rooms/StartingRoom.tscn"

@export var room_scenes: Array[String] = [
	"res://Scenes/Rooms/Level1_1.tscn",
	"res://Scenes/Rooms/Level1_2.tscn",
	"res://Scenes/Rooms/Level1_3.tscn",
	"res://Scenes/Rooms/Level1_4.tscn",
	"res://Scenes/Rooms/Level2_1.tscn",
    "res://Scenes/Rooms/Level3_1.tscn"
]

const SAVE_PATH := "user://world.save"

signal room_changed(pos: Vector2, scene_path: String)
signal world_saved()
signal world_loaded()

var world_map: Dictionary = {}
var current_pos: Vector2 = Vector2.ZERO
var current_room: Node = null

var rng := RandomNumberGenerator.new()


func _ready() -> void:
	rng.randomize()

	if not load_world():
		world_map.clear()
		world_map[current_pos] = starting_room

	# WICHTIG: load_room_at braucht jetzt 2 Parameter
	load_room_at(current_pos, Vector2.ZERO)


func move(direction: Vector2):
	var old_pos = current_pos
	var new_pos = current_pos + direction
	current_pos = new_pos

	# WICHTIG: Richtung weitergeben
	load_room_at(new_pos, direction)


func load_room_at(pos: Vector2, direction: Vector2) -> void:
	if not world_map.has(pos):
		world_map[pos] = generate_room_for(pos)

	var scene_path: String = world_map[pos]

	var packed: PackedScene = load(scene_path)
	if packed == null:
		push_error("Map.gd: Szene konnte nicht geladen werden: %s" % scene_path)
		return

	var instance: Node = packed.instantiate()

	# WICHTIG: Raum SOFORT löschen
	if current_room:
		current_room.call_deferred("free")

	add_child(instance)
	current_room = instance

	emit_signal("room_changed", pos, scene_path)

	# WICHTIG: Richtung an den Raum übergeben
	if instance.has_method("on_enter_from"):
		instance.call("on_enter_from", direction)


func generate_room_for(pos: Vector2) -> String:
	return _pick_random_room_excluding_neighbors(pos)


func _pick_random_room_excluding_neighbors(pos: Vector2) -> String:
	var neighbor_paths: Array[String] = []
	var dirs := [
		Vector2(0, -1),
		Vector2(1, 0),
		Vector2(0, 1),
		Vector2(-1, 0)
	]

	for d in dirs:
		var npos: Vector2 = pos + d
		if world_map.has(npos):
			neighbor_paths.append(world_map[npos])

	var candidates: Array[String] = []
	for p in room_scenes:
		if not neighbor_paths.has(p):
			candidates.append(p)

	if candidates.is_empty():
		candidates = room_scenes.duplicate()

	return candidates[rng.randi_range(0, candidates.size() - 1)]


func save_world() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if not file:
		push_error("Map.gd: Save-Datei konnte nicht geöffnet werden.")
		return

	file.store_var(world_map)
	file.store_var(current_pos)
	file.close()

	emit_signal("world_saved")


func load_world() -> bool:
	if not FileAccess.file_exists(SAVE_PATH):
		return false

	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not file:
		return false

	world_map = file.get_var()
	current_pos = file.get_var()
	file.close()

	emit_signal("world_loaded")
	return true


func clear_save() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		DirAccess.remove_absolute(SAVE_PATH)

	world_map.clear()
	current_pos = Vector2.ZERO
