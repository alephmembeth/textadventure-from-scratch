@tool

extends PanelContainer
class_name Area

@export_multiline var area_name : String = "Area Name" : set = set_area_name
@export_multiline var area_description : String = "Description of the area." : set = set_area_description

var exits: Dictionary = {}


func set_area_name(new_area_name: String):
	$margins/rows/area_name.text = new_area_name
	area_name = new_area_name


func set_area_description(new_area_description: String):
	$margins/rows/area_description.text = new_area_description
	area_description = new_area_description


func connect_exits(direction: String, area: Area):
	match direction:
		"north":
			exits[direction] = area
			area.exits["south"] = self
		"east":
			exits[direction] = area
			area.exits["west"] = self
		"south":
			exits[direction] = area
			area.exits["north"] = self
		"west":
			exits[direction] = area
			area.exits["east"] = self
		_:
			printerr("Tried to connect invalid direction: %s", direction)
