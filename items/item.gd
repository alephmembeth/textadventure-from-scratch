extends Resource
class_name Item

@export var item_name: String = "Item Name"
@export var item_type: Types.item_types = Types.item_types.KEY

var use_value = null


func initialize(item_name: String, item_type: Types.item_types):
	self.item_name = item_name
	self.item_type = item_type
