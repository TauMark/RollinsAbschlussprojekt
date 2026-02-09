extends CharacterBody2D

@export var speed = 400
@onready var sprite: AnimatedSprite2D = $Sprite

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	return input_direction

func _physics_process(delta):
	move_and_slide()
	

func _process(delta):
	var direction = get_input()
	handle_animation(direction)

func handle_animation(direction):
	print(sprite)
	if direction.x > 0:
		sprite.scale.x = -1
		sprite.play("walk")
	elif direction.x < 0:
		sprite.scale.x = 1
		sprite.play("walk")
