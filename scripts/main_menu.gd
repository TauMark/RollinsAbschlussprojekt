extends Control

var savedir = "res://data/"
var map = [["res://Scenes/StartingRoom.tscn"]]
var current_location = [0,0]
@export var startScene = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_new_game_pressed() -> void:
	DirAccess.remove_absolute("res://data/mapdata.json")
	DirAccess.remove_absolute("res://data/playerdata.json")
	print(map[current_location[0]][current_location[1]])
	get_tree().change_scene_to_file(map[current_location[0]][current_location[1]]) #change later to switch to game scene


func _on_load_game_pressed() -> void:
	var mapFile = FileAccess.open(savedir+"mapdata.json",FileAccess.READ)
	var playerFile = FileAccess.open(savedir+"playerdata.json",FileAccess.READ)
	if FileAccess.file_exists(savedir+"mapdata.json"):
		map = JSON.parse_string(mapFile.get_as_text())
	if FileAccess.file_exists(savedir+"playerdata.json"):
		current_location = JSON.parse_string(playerFile.get_as_text())
	get_tree().change_scene_to_file(map[current_location[0]][current_location[1]])


func _on_exit_pressed() -> void:
	get_tree().quit()
