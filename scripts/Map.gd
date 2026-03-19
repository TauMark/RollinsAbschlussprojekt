extends Node2D

var dir = "res://Scenes/Rooms/"
var savedir = "res://data/"

	

	


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
