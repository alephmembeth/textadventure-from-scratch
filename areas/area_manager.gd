extends Node


func _ready() -> void:
	var key = Item.new()
	key.initialize("key", Types.item_types.KEY)
	key.use_value = $shed
	
	$inside.connect_exits_unlocked("east", $outside)
	
	$outside.add_item(key)
	$outside.connect_exits_locked("east", $shed)
	$outside.connect_exits_unlocked("north", $street)
