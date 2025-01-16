extends CharacterBody2D

@export var gravity: float = 900
@export var jump_force: float = -400
@export var jump_delay: float = 0.5
@export var move_speed: float = 100

var direction: int = -1
var time_since_jump: float = 0.0

func _physics_process(delta: float) -> void:
	# 1) Apply gravity
	velocity.y += gravity * delta

	# 2) Timed jump
	time_since_jump += delta
	if time_since_jump >= jump_delay and is_on_floor():
		velocity.y = jump_force
		time_since_jump = 0.0

	velocity.x = direction * move_speed

	move_and_slide()

	# 5) Check collisions
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var normal = collision.get_normal()

		if normal.x > 0.7:
			direction = 1  # switch to moving right

		if normal.x < -0.7:
			direction = -1  # switch to moving left
