extends Node2D

@onready var player := get_tree().get_first_node_in_group("player")

func on_enter_from(direction: Vector2) -> void:
	var spawn_position: Vector2

	if direction == Vector2(0, -1):
		spawn_position = $DoorOne.global_position

	elif direction == Vector2(0, 1):
		spawn_position = $DoorThree.global_position

	elif direction == Vector2(1, 0):
		spawn_position = $DoorTwo.global_position

	elif direction == Vector2(-1, 0):
		spawn_position = $DoorFour.global_position

	player.global_position = spawn_position
