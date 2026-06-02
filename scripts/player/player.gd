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

	# Play animation based on movement
	if direction != Vector2.ZERO:
		anim.play("idle_down")  # we'll add walk animations later
	else:
		anim.play("idle_down")
