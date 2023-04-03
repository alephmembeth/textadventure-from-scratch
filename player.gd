extends Node

var inventory: Array = []


func take_item(item: Item):
	inventory.append(item)


func drop_item(item: Item):
	inventory.erase(item)


func get_inventory_description() -> String:
	if inventory.size() == 0:
		return "You don't carry any items."
	
	var item_description = ""
	for item in inventory:
		item_description += item.item_name + " "
	return "Inventory: " + item_description
