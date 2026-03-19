extends Area2D

@export var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	# Sicherstellen, dass das Signal verbunden ist
	if not is_connected("body_entered", Callable(self, "_on_body_entered")):
		connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	print("Tür ausgelöst:", name, "Body:", body)
	print("Ist Player in Gruppe:", body.is_in_group("player"))

	# Nur auf den Spieler reagieren
	if not body.is_in_group("player"):
		return

	print("Player erkannt, bewege Map in Richtung:", direction)
	Map.move(direction)
