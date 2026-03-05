extends Node2D

var dir = "res://Scenes/Rooms/"
var savedir = "res://data/"
var possibleRooms = DirAccess.open(dir).get_files()

var rnd = RandomNumberGenerator.new()
var map = [["res://Scenes/StartingRoom.tscn"]]
var current_location = [0,0]


func _ready() -> void:
	var mapFile = FileAccess.open(savedir+"mapdata.json",FileAccess.READ)
	var playerFile = FileAccess.open(savedir+"playerdata.json",FileAccess.READ)
	if FileAccess.file_exists(savedir+"mapdata.json"):
		map = JSON.parse_string(mapFile.get_as_text())
		print(map)
		updateMap()
	else:
		updateMap()
	if FileAccess.file_exists(savedir+"playerdata.json"):
		current_location = JSON.parse_string(playerFile.get_as_text())
		current_location[0] = int(current_location[0])
		current_location[1] = int(current_location[1])
		print(current_location)
		updatePlayer()
	else:
		updatePlayer()
	
func updateMap():
	var json = JSON.stringify(map,'\t');
	var file = FileAccess.open(savedir+"mapdata.json",FileAccess.WRITE)
	file.store_string(json)
	file.close()
	
func updatePlayer():
	var json = JSON.stringify(current_location,'\t');
	var file = FileAccess.open(savedir+"playerdata.json",FileAccess.WRITE)
	file.store_string(json)
	file.close()


func _on_door_body_entered_right(body: Node2D) -> void:
	if(body.is_in_group('Player')):
		var room = dir + possibleRooms[rnd.randi_range(0,possibleRooms.size() - 1)]
		current_location[1] += 1
		if(map[current_location[0]].size() - 1 >= current_location[1]):
			get_tree().change_scene_to_file(map[current_location[0]][current_location[1]])
		else:
			map[current_location[0]].push_back(room)
			get_tree().change_scene_to_file(room)
		updateMap()
		updatePlayer()


func _on_body_entered_down(body: Node2D) -> void:
	if(body.is_in_group('Player')):
		var room = dir + possibleRooms[rnd.randi_range(0,possibleRooms.size() - 1)]
		current_location[0] += 1
		if(map.size() - 1 >= current_location[0]):
			get_tree().change_scene_to_file(map[current_location[0]][current_location[1]])
		else:
			map.push_back([room])
			get_tree().change_scene_to_file(room)
		updateMap()
		updatePlayer()


func _on_body_entered_up(body: Node2D) -> void:
	if(body.is_in_group('Player')):
		print('up')
		var room = dir + possibleRooms[rnd.randi_range(0,possibleRooms.size() - 1)]
		if current_location[0] != 0:
			current_location[0] -= 1
		if(map.size() - 1 >= current_location[0]):
			get_tree().change_scene_to_file(map[current_location[0]][current_location[1]])
		else:
			map.push_front([room])
			get_tree().change_scene_to_file(room)
		updateMap()
		updatePlayer()


func _on_body_entered_left(body: Node2D) -> void:
	if(body.is_in_group('Player')):
		print('left')
		var room = dir + possibleRooms[rnd.randi_range(0,possibleRooms.size() - 1)]
		if current_location[1] != 0:
			current_location[1] -= 1
		if(map[current_location[0]].size() - 1 >= current_location[1]):
			get_tree().change_scene_to_file(map[current_location[0]][current_location[1]])
		else:
			map[current_location[0]].push_front(room)
			get_tree().change_scene_to_file(room)
		updateMap()
		updatePlayer()
