extends CharacterBody2D

@export var speed = 400

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	print(input_direction)
	if input_direction.x == 1:
		$Sprite2D.scale.x = -1
	elif input_direction.x == -1:
		$Sprite2D.scale.x = 1
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
