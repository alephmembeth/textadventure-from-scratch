extends Resource
class_name Exits

var area_1 = null
var area_1_is_locked := false

var area_2 = null
var area_2_is_locked := false


func is_other_area_locked(current_area) -> bool:
	if current_area == area_1:
		return area_2_is_locked
	elif current_area == area_2:
		return area_1_is_locked
	else:
		printerr("The area you tried to find is not connected to this exit.")
		return true


func get_other_area(current_area):
	if current_area == area_1:
		return area_2
	elif current_area == area_2:
		return area_1
	else:
		printerr("The area you tried to find is not connected to this exit.")
		return null
