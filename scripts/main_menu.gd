extends Control

@export var startScene = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_new_game_pressed() -> void:
<<<<<<< Updated upstream
	get_tree().change_scene_to_file(startScene) #change later to switch to game scene
=======
	get_tree().change_scene_to_file("res://Scenes/Level1.tscn") #change later to switch to game scene
>>>>>>> Stashed changes


func _on_load_game_pressed() -> void:
	print("Load Game Pressed") # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
