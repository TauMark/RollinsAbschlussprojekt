extends Control

@onready var label = $Label
var savedir = "user://"

func _process(delta):
	label.text = "Punkte: " + str(get_points())


func get_points() -> int:
	if not FileAccess.file_exists(savedir + "playerdata.json"):
		return 0
	
	var file = FileAccess.open(savedir + "playerdata.json", FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	file.close()
	
	if typeof(data) == TYPE_DICTIONARY and data.has("point_counter"):
		return int(data["point_counter"])
	
	return 0
