extends Node2D

func _ready():
	Map.load_room_at(Map.current_pos)
