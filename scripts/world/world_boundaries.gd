extends Node2D

# World boundary walls — invisible StaticBody2D walls around the map edges.
# Map is 40 tiles wide x 30 tiles tall at 16px per tile = 640 x 480 px.
# Adjust MAP_WIDTH / MAP_HEIGHT if you repaint the tilemap later.

const MAP_WIDTH = 160   # 10 tiles wide (5 tiles each side)
const MAP_HEIGHT = 160  # 10 tiles tall (5 tiles each side)
const WALL_THICKNESS = 32

# Centered on player spawn
const CENTER = Vector2(320, 240)

func _ready():
	print("WorldBoundaries script running")
	var left   = CENTER.x - MAP_WIDTH / 2.0
	var right  = CENTER.x + MAP_WIDTH / 2.0
	var top    = CENTER.y - MAP_HEIGHT / 2.0
	var bottom = CENTER.y + MAP_HEIGHT / 2.0

	_create_wall(Vector2(CENTER.x, top - WALL_THICKNESS / 2.0),    MAP_WIDTH, WALL_THICKNESS)  # top
	_create_wall(Vector2(CENTER.x, bottom + WALL_THICKNESS / 2.0), MAP_WIDTH, WALL_THICKNESS)  # bottom
	_create_wall(Vector2(left - WALL_THICKNESS / 2.0,  CENTER.y),  WALL_THICKNESS, MAP_HEIGHT) # left
	_create_wall(Vector2(right + WALL_THICKNESS / 2.0, CENTER.y),  WALL_THICKNESS, MAP_HEIGHT) # right

func _create_wall(pos: Vector2, width: float, height: float):
	var body = StaticBody2D.new()
	body.position = pos

	var shape = CollisionShape2D.new()
	var rect = RectangleShape2D.new()
	rect.size = Vector2(width, height)
	shape.shape = rect

	body.add_child(shape)
	add_child(body)
