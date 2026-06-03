extends CharacterBody2D

const SPEED = 150.0

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	$Camera2D.make_current()

func _physics_process(_delta: float) -> void:
	var direction := Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)

	velocity = direction.normalized() * SPEED if direction != Vector2.ZERO else Vector2.ZERO
	move_and_slide()
	_update_animation(direction)

func _update_animation(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		# Standing still — swap to matching idle
		var current = anim.animation
		if current == "walk_down" or current == "idle_down":
			anim.play("idle_down")
		elif current == "walk_side" or current == "idle_side":
			anim.play("idle_side")
		elif current == "walk_up" or current == "idle_up":
			anim.play("idle_up")
	else:
		# Moving — pick walk animation based on direction
		if abs(direction.x) > abs(direction.y):
			# Horizontal movement dominates
			anim.flip_h = direction.x < 0
			anim.play("walk_side")
		elif direction.y > 0:
			anim.flip_h = false
			anim.play("walk_down")
		else:
			anim.flip_h = false
			anim.play("walk_up")
