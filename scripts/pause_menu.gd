extends Control

var savedir = "user://"
var player = ""

func _ready() -> void:
	hide()
	$AnimationPlayer.play("RESET")
	player = $"../.."

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("PauseMenu")
	await $AnimationPlayer.animation_finished
	hide()

	

func pause():
	show()
	get_tree().paused = true
	$AnimationPlayer.play("PauseMenu")
	
	
func testEsc():
	if Input.is_action_just_pressed("esc") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused == true:
		resume()

func _on_resume_pressed() -> void:
	resume()


func _on_save_game_pressed() -> void:
	var data = {}
	
	if FileAccess.file_exists(savedir + "playerdata.json"):
		var file_r = FileAccess.open(savedir + "playerdata.json", FileAccess.READ)
		data = JSON.parse_string(file_r.get_as_text())
		file_r.close()
		
		if typeof(data) != TYPE_DICTIONARY:
			data = {}
	
	data["x"] = player.position.x
	data["y"] = player.position.y
	
	var file_w = FileAccess.open(savedir + "playerdata.json", FileAccess.WRITE)
	file_w.store_string(JSON.stringify(data, "\t"))
	file_w.close()


func _on_main_menu_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn") 
	
	


func _on_quit_pressed() -> void:
	get_tree().quit()
	
func _process(delta: float) -> void:
	testEsc()
	
