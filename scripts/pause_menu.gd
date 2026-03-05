extends Control

func _ready() -> void:
	hide()
	$AnimationPlayer.play("RESET")

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
	pass # Replace with Save Function bismilah


func _on_main_menu_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn") 
	
	


func _on_quit_pressed() -> void:
	get_tree().quit()
	
func _process(delta: float) -> void:
	testEsc()
	
