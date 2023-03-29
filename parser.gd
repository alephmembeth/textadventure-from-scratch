extends Node

var current_area = null


func initialize(starting_area) -> String:
	return change_area(starting_area)


func process_command(input: String) -> String:
	var words = input.split(" ", false)
	if words.size() == 0:
		return "No words were parsed."
	
	var first_word = words[0].to_lower()
	var second_word = ""
	if words.size() > 1:
		second_word = words[1].to_lower()
	
	match first_word:
		"go":
			return go(second_word)
		"help":
			return help()
		_:
			return "I don't understand that."


func go(second_word: String) -> String:
	if second_word == "":
		return "Go where?"
		
	if current_area.exits.keys().has(second_word):
		var change_response = change_area(current_area.exits[second_word])
		var change_info_string = PackedStringArray(["You go %s." % second_word, change_response])
		var change_info = "\n".join(change_info_string)
		return change_info
	else:
		return "There is no exit in this direction."


func help() -> String:
	return "You can use these commands: 'go [location]', 'help'."


func change_area(new_area: Area) -> String:
	current_area = new_area
	var exit_info_string = PackedStringArray(new_area.exits.keys())
	var exit_info = " ".join(exit_info_string)

	var area_info_string = PackedStringArray([
		"You are currently " + new_area.area_name + ". It is " + new_area.area_description,
		"Exits: " + exit_info
	])
	var area_info = "\n".join(area_info_string)
	return area_info
