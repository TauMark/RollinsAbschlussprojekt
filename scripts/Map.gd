extends Node2D

var dir = "res://Scenes/Rooms/"
var savedir = "user://"

	

	


func _on_door_body_entered_right(body: Node2D) -> void:
	if(body.is_in_group('Player')):
		body.position += Vector2(250,0)

func _on_body_entered_down(body: Node2D) -> void:
	if(body.is_in_group('Player')):
		body.position += Vector2(0,300)

func _on_body_entered_up(body: Node2D) -> void:
	if(body.is_in_group('Player')):
		body.position -= Vector2(0,300)

func _on_body_entered_left(body: Node2D) -> void:
	if(body.is_in_group('Player')):
		body.position -= Vector2(250,0)

func get_points_from_file() -> int:
	var path = "user://playerdata.json"
	
	if not FileAccess.file_exists(path):
		return 0
	
	var file = FileAccess.open(path, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	file.close()
	
	if typeof(data) == TYPE_DICTIONARY and data.has("point_counter"):
		return int(data["point_counter"])
	
	return 0

	


func _on_dour_end_body_entered(body: Node2D) -> void:
	if(body.is_in_group('Player')):
		var points = get_points_from_file()
		
		if points > 9:
			get_tree().change_scene_to_file("res://Scenes/EndScreen.tscn")
		else:
			print("Mindestens 10 Punkte benötigt!")
