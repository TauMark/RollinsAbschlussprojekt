extends Area2D

@export var room_scene = "res://Scenes/Main.tscn"



func _on_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file(room_scene)
