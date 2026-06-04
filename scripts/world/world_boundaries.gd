extends Node2D

# Automatically calculates boundaries from the TileMapLayer's actual painted area.
# No need to manually update MAP_WIDTH/HEIGHT when you repaint the tilemap.

const WALL_THICKNESS = 64

func _ready():
	var tilemap = get_parent().get_node("TileMapLayer")

	# get_used_rect() returns tile coordinates of the painted area
	var used_rect = tilemap.get_used_rect()
	var tile_size = tilemap.tile_set.tile_size
	var tmap_scale = tilemap.scale
	var tmap_pos = tilemap.position

	# Convert tile rect to world coordinates
	var world_left   = tmap_pos.x + used_rect.position.x * tile_size.x * tmap_scale.x
	var world_top    = tmap_pos.y + used_rect.position.y * tile_size.y * tmap_scale.y
	var world_right  = tmap_pos.x + used_rect.end.x * tile_size.x * tmap_scale.x
	var world_bottom = tmap_pos.y + used_rect.end.y * tile_size.y * tmap_scale.y

	var world_width  = world_right - world_left
	var world_height = world_bottom - world_top
	var center = Vector2((world_left + world_right) / 2.0, (world_top + world_bottom) / 2.0)

	print("Island bounds: ", world_left, ",", world_top, " to ", world_right, ",", world_bottom)

	_create_wall(Vector2(center.x, world_top - WALL_THICKNESS / 2.0),    world_width + WALL_THICKNESS * 2, WALL_THICKNESS)  # top
	_create_wall(Vector2(center.x, world_bottom + WALL_THICKNESS / 2.0), world_width + WALL_THICKNESS * 2, WALL_THICKNESS)  # bottom
	_create_wall(Vector2(world_left - WALL_THICKNESS / 2.0, center.y),   WALL_THICKNESS, world_height + WALL_THICKNESS * 2) # left
	_create_wall(Vector2(world_right + WALL_THICKNESS / 2.0, center.y),  WALL_THICKNESS, world_height + WALL_THICKNESS * 2) # right

func _create_wall(pos: Vector2, width: float, height: float):
	var body = StaticBody2D.new()
	body.position = pos
	var shape = CollisionShape2D.new()
	var rect = RectangleShape2D.new()
	rect.size = Vector2(width, height)
	shape.shape = rect
	body.add_child(shape)
	add_child(body)
