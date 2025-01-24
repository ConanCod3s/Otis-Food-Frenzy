extends CharacterBody2D

@export var gravity: float = 900
@export var jump_force: float = -400
@export var jump_delay: float = 0.5
@export var move_speed: float = 100

var direction: int = -1
var time_since_jump: float = 0.0

func _ready():
	randomize()  # Ensures random numbers differ each time the game runs

func _physics_process(delta: float) -> void:
	# Apply gravity
	velocity.y += gravity * delta

	# Timed jump
	time_since_jump += delta
	if time_since_jump >= jump_delay and is_on_floor():
		velocity.y = jump_force
		time_since_jump = 0.0

	# Move horizontally
	velocity.x = direction * move_speed

	move_and_slide()

	# Check collisions & flip direction
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var normal = collision.get_normal()

		if normal.x > 0.7:
			direction = 1
		elif normal.x < -0.7:
			direction = -1

func die():
	# Spawn a new burger at a random position
	var burger_scene = preload("res://Scenes/Enemies/JumpingBurger/JumpingBurger.tscn")
	var new_burger = burger_scene.instantiate()

	# Pick random coordinates within your level boundaries
	var random_x = randf_range(0, 1000)
	var random_y = randf_range(0, 600)
	new_burger.global_position = Vector2(random_x, random_y)

	get_tree().current_scene.add_child(new_burger)

	# Remove this burger
	queue_free()
