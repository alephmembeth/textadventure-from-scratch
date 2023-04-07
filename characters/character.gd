extends Resource
class_name Character

@export_multiline var character_name: String = "Character Name"

@export_multiline var initial_dialog: String
@export_multiline var follow_up_dialog: String

@export var quest_item: Item

var has_received_quest_item := false
var quest_reward = null
