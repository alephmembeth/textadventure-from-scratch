@tool

extends PanelContainer
class_name Area

@export_multiline var area_name: String = "Area Name": set = set_area_name
@export_multiline var area_description: String = "Description of the area.": set = set_area_description

var exits: Dictionary = {}
var characters: Array = []
var items: Array = []


func set_area_name(new_area_name: String):
	$margins/rows/area_name.text = new_area_name
	area_name = new_area_name


func set_area_description(new_area_description: String):
	$margins/rows/area_description.text = new_area_description
	area_description = new_area_description


func add_character(character: Character):
	characters.append(character)


func add_item(item: Item):
	items.append(item)


func remove_item(item: Item):
	items.erase(item)


func get_full_description() -> String:
	return area_description


func get_area_description() -> String:
	return area_description


func get_area_name() -> String:
	return "Location: \n" + Types.wrap_area_text(area_name)


func get_character_description() -> String:
	if characters.size() == 0:
		return ""
	
	var character_description = ""
	for character in characters:
		character_description += character.character_name + "\n"
	return "People: \n" + Types.wrap_character_text(character_description)


func get_item_description() -> String:
	if items.size() == 0:
		return ""
	
	var item_description = ""
	for item in items:
		item_description += item.item_name + "\n"
	return "Items: \n" + Types.wrap_item_text(item_description)


func get_exit_description() -> String:
	var exit_description_string = PackedStringArray(exits.keys())
	var exit_description = "\n".join(exit_description_string)
	return "Exits: \n" + Types.wrap_area_text(exit_description)


func connect_exits_unlocked(direction: String, area: Area, area_2_override = "null"):
	return _connect_exits(direction, area, false, area_2_override)


func connect_exits_locked(direction: String, area: Area, area_2_override = "null"):
	return _connect_exits(direction, area, true, area_2_override)


func _connect_exits(direction: String, area: Area, is_locked: bool = false, area_2_override = "null"):
	var exit = Exits.new()
	exit.area_1 = self
	exit.area_2 = area
	exit.area_is_locked = is_locked
	exits[direction] = exit
	
	if area_2_override != "null":
		area.exits[area_2_override] = exit
	else:
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
			"inside":
				area.exits["outside"] = exit
			"outside":
				area.exits["inside"] = exit
			_:
				printerr("Tried to connect invalid direction: %s", direction)
	return exit
