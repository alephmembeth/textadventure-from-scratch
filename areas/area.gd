@tool

extends PanelContainer
class_name Area

@export_multiline var area_name: String = "Area Name": set = set_area_name
@export_multiline var area_description: String = "Description of the area.": set = set_area_description

var exits: Dictionary = {}
var items: Array = []


func set_area_name(new_area_name: String):
	$margins/rows/area_name.text = new_area_name
	area_name = new_area_name


func set_area_description(new_area_description: String):
	$margins/rows/area_description.text = new_area_description
	area_description = new_area_description


func add_item(item: Item):
	items.append(item)


func get_full_description() -> String:
	var area_description_string = PackedStringArray([
		get_area_description(),
		get_item_description(),
		get_exit_description()
	])
	var full_description = "\n".join(area_description_string)
	return full_description


func get_area_description() -> String:
	return "You are currently " + area_name + ". It is " + area_description


func get_item_description() -> String:
	if items.size() == 0:
		return "Items: There are no items to pick up."
	
	var item_description = ""
	for item in items:
		item_description += item.item_name + " "
	return "Items: " + item_description


func get_exit_description() -> String:
	var exit_description_string = PackedStringArray(exits.keys())
	var exit_description = " ".join(exit_description_string)
	return "Exits: " + exit_description


func connect_exits(direction: String, area: Area):
	var exit = Exits.new()
	exit.area_1 = self
	exit.area_2 = area
	exits[direction] = exit
	
	match direction:
		"north":
			area.exits["south"] = exit
		"east":
			area.exits["west"] = exit
		"south":
			area.exits["north"] = exit
		"west":
			area.exits["east"] = exit
		"up":
			area.exits["down"] = exit
		"down":
			area.exits["up"] = exit
		_:
			printerr("Tried to connect invalid direction: %s", direction)
