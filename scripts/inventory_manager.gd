extends Node3D
class_name InventoryManager

# Array storing items
var inventory: Array[Item]

func add_item_to_inventory(item: Item):
	inventory.append(item)

func remove_item_from_inventory(item: Item):
	# implement when item picking up and dropping is sorted out
	pass
