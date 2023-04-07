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
		"use":
			return use(second_word)
		"give":
			return give(second_word)
		"talk":
			return talk(second_word)
		"help":
			return help()
		_:
			return "I don't understand that."


func go(second_word: String) -> String:
	if second_word == "":
		return "Go where?"
	
	if current_area.exits.keys().has(second_word):
		var exit = current_area.exits[second_word]
		if exit.area_is_locked:
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


func use(second_word: String) -> String:
	if second_word == "":
		return "Use what?"
	
	for item in player.inventory:
		if second_word.to_lower() == item.item_name.to_lower():
			match item.item_type:
				Types.item_types.KEY:
					for exit in current_area.exits.values():
						if exit == item.use_value:
							exit.area_is_locked = false
							player.drop_item(item)
							return "You unlock the door with the %s and can now go to %s." % [item.item_name, exit.get_other_area(current_area).area_name]
					return "That item does not unlock anything in this room."
				_:
					return "Tried to use item with invalid item type."
	
	return "You can't use %s." % second_word


func give(second_word: String) -> String:
	if second_word == "":
		return "Give what?"
	
	var has_item := false
	for item in player.inventory:
		if second_word.to_lower() == item.item_name.to_lower():
			has_item = true
	
	if not has_item:
		return "You don't have %s." % second_word
	
	for character in current_area.characters:
		if character.quest_item != null and second_word.to_lower() == character.quest_item.item_name.to_lower():
			character.has_received_quest_item = true
			for item in player.inventory:
				if second_word.to_lower() == item.item_name.to_lower():
					player.drop_item(item)
			
			if character.quest_reward != null:
				var reward = character.quest_reward
				if "is_locked" in reward:
					reward.is_locked = false
				elif "key" in reward:
					player.take_item(reward)
				else:
					printerr("Quest reward is not defined.")
			
			return "You give %s to the %s." % [second_word, character.character_name]
	
	return "You can't give %s." % second_word


func talk(second_word: String) -> String:
	if second_word == "":
		return "Talk with whom?"
	
	for character in current_area.characters:
		if character.character_name.to_lower() == second_word:
			var dialog = character.follow_up_dialog if character.has_received_quest_item else character.initial_dialog
			return character.character_name + ": \"" + dialog + "\""
	
	return "You can't talk with %s." % second_word


func help() -> String:
	return "You can use these commands: go [exit], take [item], drop [item], use [item], give [item], talk [character], inventory, help."


func change_area(new_area: Area) -> String:
	current_area = new_area
	return new_area.get_full_description()
