# Otis.gd
extends CharacterBody2D

signal player_hurt

const SPEED = 500
const JUMP_FORCE = -500
const GRAVITY = 900

func _physics_process(delta: float) -> void:
	# 1) Horizontal input
	var input_direction = 0
	if Input.is_action_pressed("ui_left"):
		input_direction -= 1
	if Input.is_action_pressed("ui_right"):
		input_direction += 1

	# 2) Apply horizontal movement
	velocity.x = input_direction * SPEED

	# 3) Jump if on floor
	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_FORCE

	# 4) Apply gravity
	velocity.y += GRAVITY * delta

	# 5) Move and slide
	move_and_slide()

	# 6) Check collisions after movement
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		var collision_normal = collision.get_normal()

		if collider is CharacterBody2D:
			# If colliding from above
			if collision_normal.y < -0.7:
				print("stomped the enemy")
				collider.queue_free()
				velocity.y = JUMP_FORCE * 0.5  # small bounce
			else:
				# Player is hurt
				$Sprite2D.modulate = Color(1, 0, 0)  # flash red
				GameManager.lose_life()
				# If lives <= 0, you might do: get_tree().change_scene("res://...")
