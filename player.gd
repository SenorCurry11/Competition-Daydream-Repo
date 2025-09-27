extends CharacterBody2D

# --- Movement Properties ---
@export var speed: float = 300.0
@export var jump_velocity: float = 400.0

# Get the gravity from the project settings to be applied every frame.
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

# --- Built-in Godot Function (runs every frame) ---
func _physics_process(delta: float) -> void:
	# 1. Apply Gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# 2. Handle Jump
	# Check if the "jump" action is pressed AND the character is on the floor.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = -jump_velocity # Negative Y is up in 2D

	# 3. Get Input Direction
	var direction: float = Input.get_axis("ui_left", "ui_right")

	# 4. Handle Horizontal Movement
	if direction:
		velocity.x = direction * speed
	else:
		# Smoothly slow down the character when no input is given
		velocity.x = move_toward(velocity.x, 0, speed)

	# 5. Move the Character
	move_and_slide()
