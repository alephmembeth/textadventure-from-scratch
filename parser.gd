extends Node

var current_area = null
var player = null


func initialize(starting_area, player) -> String:
	self.player = player
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
		"take":
			return take(second_word)
		"drop":
			return drop(second_word)
		"inventory":
			return inventory()
		"help":
			return help()
		_:
			return "I don't understand that."


func go(second_word: String) -> String:
	if second_word == "":
		return "Go where?"
	
	if current_area.exits.keys().has(second_word):
		var exit = current_area.exits[second_word]
		if exit.is_other_area_locked(current_area):
			return "You can't go to %s. It is locked." % second_word
		var change_response = change_area(exit.get_other_area(current_area))
		var change_info_string = PackedStringArray(["You go %s." % second_word, change_response])
		var change_info = "\n".join(change_info_string)
		return change_info
	else:
		return "You can't go to %s." % second_word


func take(second_word: String) -> String:
	if second_word == "":
		return "Take what?"
	
	for item in current_area.items:
		if second_word.to_lower() == item.item_name.to_lower():
			current_area.remove_item(item)
			player.take_item(item)
			return "You take the " + item.item_name + "."
	
	return "You can't take %s." % second_word


func drop(second_word: String) -> String:
	if second_word == "":
		return "Drop what?"
	
	for item in player.inventory:
		if second_word.to_lower() == item.item_name.to_lower():
			player.drop_item(item)
			current_area.add_item(item)
			return "You drop the " + item.item_name + "."
	
	return "You can't drop %s." % second_word


func inventory() -> String:
	return player.get_inventory_description()


func help() -> String:
	return "You can use these commands: go [exit], take [item], drop [item], inventory, help."


func change_area(new_area: Area) -> String:
	current_area = new_area
	return new_area.get_full_description()
