extends Area2D

@export var resource_type: String = "wood"
@export var resource_amount: int = 1

var player_nearby: bool = false

@onready var label = $Label
@onready var sprite = $Sprite2D

const SPRITE_REGIONS = {
	"wood":  Rect2(0,  48, 16, 16),
	"fuel":  Rect2(0,  16, 40, 16),
	"scrap": Rect2(64, 48, 16, 16),
}

func _ready():
	if resource_type in SPRITE_REGIONS:
		var atlas = sprite.texture as AtlasTexture
		if atlas:
			atlas = atlas.duplicate()
			atlas.region = SPRITE_REGIONS[resource_type]
			sprite.texture = atlas
	if resource_type == "scrap":
		sprite.scale = Vector2(4, 4)
	if resource_type == "fuel":
		sprite.scale = Vector2(1, 1)

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
	# Hand the resource to the global Inventory singleton. The UI listens to
	# Inventory's signal and updates itself — this node doesn't touch the UI.
	Inventory.add(resource_type, resource_amount)
	print("Picked up: ", resource_amount, "x ", resource_type)
	queue_free()
