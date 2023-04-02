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
