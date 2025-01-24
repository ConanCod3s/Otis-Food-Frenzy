extends CharacterBody2D

signal player_hurt

const SPEED = 500
const JUMP_FORCE = -400
const GRAVITY = 900

# How many times Otis can jump
const MAX_JUMPS = 2

# Track how many jumps done since last landing
var jump_count = 0

# Invincibility variables
var invincible = false
var invincible_duration = 0.5
var invincible_timer = 0.0

func _physics_process(delta: float) -> void:
	# Handle invincibility timing
	if invincible:
		invincible_timer -= delta
		if invincible_timer <= 0:
			invincible = false
			$Sprite2D.modulate = Color.WHITE  # Reset color

	# Handle horizontal input
	var input_direction = 0
	if Input.is_action_pressed("ui_left"):
		input_direction -= 1
	if Input.is_action_pressed("ui_right"):
		input_direction += 1

	velocity.x = input_direction * SPEED

	# Check if on the floor; reset jump_count if so
	if is_on_floor():
		jump_count = 0

	# Jump / Double Jump
	if Input.is_action_just_pressed("ui_accept"):
		# If we still have jumps left
		if jump_count < MAX_JUMPS:
			velocity.y = JUMP_FORCE
			jump_count += 1

	# Apply gravity
	velocity.y += GRAVITY * delta

	# Move and slide
	move_and_slide()

	# Check collisions after movement
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		var collision_normal = collision.get_normal()

		if collider is CharacterBody2D:
			# Stomp the enemy if colliding from above
			if collision_normal.y < -0.7:
				collider.die()
				velocity.y = JUMP_FORCE * 0.5  # small bounce
				break
			else:
				# Otis is hurt; handle damage and knock back
				_handle_player_hit(collider)
				break


func _handle_player_hit(enemy):
	# Only apply damage if not already invincible
	if not invincible:
		$Sprite2D.modulate = Color(1, 0, 0)  # Flash red for feedback
		GameManager.lose_life()
		
		## Knock back code - WIP, currently not working
		#var direction = (global_position - enemy.global_position).normalized()
		#velocity = direction * 300 # Knock back Strength

		# Enable invincibility
		invincible = true
		invincible_timer = invincible_duration

		# If lives <= 0, trigger your game-over logic here
		# if GameManager.lives <= 0:
		#     get_tree().change_scene("res://Scenes/GameOver.tscn")
