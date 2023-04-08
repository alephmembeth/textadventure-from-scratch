extends Node

enum item_types {
	KEY,
	QUEST_ITEM,
}

const ColorArea = Color("#FFE6C7")
const ColorCharacter = Color("#FFA559")
const ColorItem = Color("#FF6000")


func wrap_area_text(text: String) -> String:
	return "[color=#%s]%s[/color]" % [ColorArea.to_html(), text]


func wrap_character_text(text: String) -> String:
	return "[color=#%s]%s[/color]" % [ColorCharacter.to_html(), text]


func wrap_item_text(text: String) -> String:
	return "[color=#%s]%s[/color]" % [ColorItem.to_html(), text]
