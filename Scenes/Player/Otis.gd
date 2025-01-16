# Otis.gd
extends CharacterBody2D

signal player_hurt

const SPEED = 500
const JUMP_FORCE = -500
const GRAVITY = 900

func _physics_process(delta: float) -> void:
	# Horizontal input
	var input_direction = 0
	if Input.is_action_pressed("ui_left"):
		input_direction -= 1
	if Input.is_action_pressed("ui_right"):
		input_direction += 1

	# Apply horizontal movement
	velocity.x = input_direction * SPEED

	# Jump if on floor
	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_FORCE

	# Apply gravity
	velocity.y += GRAVITY * delta

	# Move and slide
	move_and_slide()

	# Check collisions after movement
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		var collision_normal = collision.get_normal()

		# This only handles Otis hitting the enemy, if the enemy hits otis nothing will happen 
		if collider is CharacterBody2D:
			# If colliding from above
			if collision_normal.y < -0.7:
				collider.queue_free()
				velocity.y = JUMP_FORCE * 0.5  # small bounce
			else:
				$Sprite2D.modulate = Color(1, 0, 0)  # Tuen red for testing to show deadge
				GameManager.lose_life()
				# If lives <= 0, do logic to end game
