extends PanelContainer
class_name Area

@export var area_name = "Area Name"
@export var area_description = "Description of the area."

var exits: Dictionary = {}


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
