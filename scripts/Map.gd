extends Node2D

var dir = "res://Scenes/Rooms/"
var savedir = "res://data/"
var possibleRooms = DirAccess.open(dir).get_files()

var rnd = RandomNumberGenerator.new()
var map = [["res://Scenes/StartingRoom.tscn"]]
var current_location = [0,0]


func _ready() -> void:

	# LOAD MAP
	if FileAccess.file_exists(savedir + "mapdata.json"):
		var mapFile = FileAccess.open(savedir + "mapdata.json", FileAccess.READ)
		map = JSON.parse_string(mapFile.get_as_text())
		mapFile.close()
		print(map)
	else:
		updateMap()

	# LOAD PLAYER DATA
	if FileAccess.file_exists(savedir + "playerdata.json"):
		var playerFile = FileAccess.open(savedir + "playerdata.json", FileAccess.READ)
		var data = JSON.parse_string(playerFile.get_as_text())
		playerFile.close()

		if typeof(data) == TYPE_DICTIONARY and data.has("current_location"):
			current_location = data["current_location"]
			current_location[0] = int(current_location[0])
			current_location[1] = int(current_location[1])
			print(current_location)

	updatePlayer()
	
func updateMap():
	var json = JSON.stringify(map,'\t');
	var file = FileAccess.open(savedir+"mapdata.json",FileAccess.WRITE)
	file.store_string(json)
	file.close()
	
func updatePlayer():
	var data = {}
	
	if FileAccess.file_exists(savedir + "playerdata.json"):
		var file_r = FileAccess.open(savedir + "playerdata.json", FileAccess.READ)
		data = JSON.parse_string(file_r.get_as_text())
		file_r.close()
		
		if typeof(data) != TYPE_DICTIONARY:
			data = {}
	
	data["current_location"] = current_location
	
	var file_w = FileAccess.open(savedir + "playerdata.json", FileAccess.WRITE)
	file_w.store_string(JSON.stringify(data, "\t"))
	file_w.close()


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
