extends Node

signal response_generated(response_text)

var current_area = null


func initialize(starting_area):
	change_area(starting_area)


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
	
	return "You go %s." % second_word


func help() -> String:
	return "You can use these commands: 'go [location], 'help'."


func change_area(new_area: area):
	current_area = new_area
	var string_array = PackedStringArray([
		"You are currently in", new_area.area_name,
		"Exits: "
	])
	var strings = "\n".join(string_array)
	emit_signal("response_generated", strings)
