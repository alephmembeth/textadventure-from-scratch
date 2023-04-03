extends Node

var inventory: Array = []


func take_item(item: Item):
	inventory.append(item)
