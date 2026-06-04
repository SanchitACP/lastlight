extends CanvasLayer

# InventoryUI — the DISPLAY (kept separate from the data on purpose).
#
# It never stores inventory numbers itself. It listens to the global
# Inventory singleton's "inventory_changed" signal and redraws the labels.
# This is the core Godot pattern: data broadcasts, display listens.

@onready var wood_label: Label = $Panel/VBoxContainer/WoodLabel
@onready var fuel_label: Label = $Panel/VBoxContainer/FuelLabel
@onready var scrap_label: Label = $Panel/VBoxContainer/ScrapLabel

func _ready() -> void:
	# Subscribe to the inventory's broadcast.
	Inventory.inventory_changed.connect(_on_inventory_changed)
	# Show the starting values right away.
	_refresh()

# Called every time the inventory changes. We ignore the arguments and just
# re-read everything — simplest and always correct for a tiny inventory.
func _on_inventory_changed(_type: String, _new_amount: int) -> void:
	_refresh()

func _refresh() -> void:
	wood_label.text = "Wood: %d" % Inventory.get_amount("wood")
	fuel_label.text = "Fuel: %d" % Inventory.get_amount("fuel")
	scrap_label.text = "Scrap: %d" % Inventory.get_amount("scrap")
