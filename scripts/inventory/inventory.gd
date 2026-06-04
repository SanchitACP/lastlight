extends Node

# Inventory — global autoload singleton (the DATA store).
#
# This script is registered as an autoload, so Godot keeps one copy of it
# loaded for the whole game. Any scene can reach it by the name "Inventory"
# without needing a direct reference. It only stores numbers — it knows
# nothing about how they are displayed. The UI is a separate scene that
# listens to the signal below.

# Broadcast whenever an amount changes. The UI connects to this and refreshes.
signal inventory_changed(type: String, new_amount: int)

# How much of each resource the player is currently carrying.
var amounts := {
	"wood": 0,
	"fuel": 0,
	"scrap": 0,
}

# Add some amount of a resource, then announce the change.
func add(type: String, count: int = 1) -> void:
	if not amounts.has(type):
		amounts[type] = 0
	amounts[type] += count
	inventory_changed.emit(type, amounts[type])

# Read the current amount of a resource (0 if we have never seen it).
func get_amount(type: String) -> int:
	return amounts.get(type, 0)
