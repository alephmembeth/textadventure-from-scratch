extends PanelContainer

@onready var area_label = $margins/rows/area_label
@onready var exit_label = $margins/rows/exits_label
@onready var charcater_label = $margins/rows/characters_label
@onready var item_label = $margins/rows/items_label
@onready var help_label = $margins/rows/help_label


func handle_area_changed(new_area):
	area_label.text = new_area.get_area_name()
	exit_label.text = new_area.get_exit_description()
	charcater_label.text = new_area.get_character_description()
	item_label.text = new_area.get_item_description()
	help_label.text = "Type 'help' for available commands."


func handle_area_updated(current_area):
	handle_area_changed(current_area)
