extends Area2D

@export var resource_type: String = "wood"
@export var resource_amount: int = 1

var player_nearby: bool = false

@onready var label = $Label

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _process(_delta):
	if player_nearby and Input.is_action_just_pressed("interact"):
		_collect()

func _on_body_entered(body):
	if body.name == "Player":
		player_nearby = true
		label.visible = true

func _on_body_exited(body):
	if body.name == "Player":
		player_nearby = false
		label.visible = false

func _collect():
	print("Picked up: ", resource_amount, "x ", resource_type)
	queue_free()
