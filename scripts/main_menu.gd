extends Control

@export var startScene = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$FadeOut.play_backwards("MainMenuFade")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_new_game_pressed() -> void:
	$FadeOut.play("MainMenuFade")
	await $FadeOut.animation_finished
	get_tree().change_scene_to_file("res://Scenes/Level1.tscn") 


func _on_load_game_pressed() -> void:
	$FadeOut.play("MainMenuFade")
	await $FadeOut.animation_finished
	print("Load Game Pressed") # Replace with function body.


func _on_exit_pressed() -> void:
	$FadeOut.play("MainMenuFade")
	await $FadeOut.animation_finished
	get_tree().quit()
