extends Node


func _ready() -> void:
	$behind_inn.connect_exits_unlocked("alley", $street_3, "alley")
	var exit_shed = $behind_inn.connect_exits_locked("shed", $shed, "outside")
	
	var sword = load_item("guard_sword")
	$shed.add_item(sword)
	
	var guard = load_character("guard")
	var backdoor_key = load_item("backdoor_key")
	guard.quest_reward = backdoor_key
	$city_gate.add_character(guard)
	$city_gate.connect_exits_unlocked("east", $street_1)
	
	$street_1.connect_exits_unlocked("east", $street_2)
	
	$street_2.connect_exits_unlocked("east", $street_3)
	
	$street_3.connect_exits_unlocked("east", $street_4)
	
	$street_4.connect_exits_unlocked("east", $street_5)
	$street_4.connect_exits_unlocked("door", $inn_door, "street")
	
	$street_5.connect_exits_unlocked("east", $street_6)
	
	$street_6.connect_exits_unlocked("east", $street_7)
	
	$street_7.connect_exits_unlocked("east", $street_8)
	
	$inn_door.connect_exits_unlocked("inside", $taproom, "outside")
	
	var innkeeper = load_character("innkeeper")
	$taproom.add_character(innkeeper)
	$taproom.connect_exits_unlocked("stairs", $stairs, "taproom")
	$taproom.connect_exits_unlocked("kitchen", $kitchen, "taproom")
	
	$stairs.connect_exits_unlocked("down", $cellar_door)
	$stairs.connect_exits_unlocked("up", $upstairs_hallway)
	
	$cellar_door.connect_exits_unlocked("cellar", $cellar, "stairs")
	
	$upstairs_hallway.connect_exits_unlocked("left", $room_1, "hallway")
	$upstairs_hallway.connect_exits_unlocked("center", $room_2, "hallway")
	$upstairs_hallway.connect_exits_unlocked("right", $room_2, "hallway")
	
	var cook = load_character("cook")
	$kitchen.add_character(cook)
	$kitchen.connect_exits_unlocked("pantry", $pantry, "kitchen")
	$kitchen.connect_exits_unlocked("backdoor", $backdoor, "kitchen")
	
	var shedkey = load_item("shed_key")
	shedkey.use_value = exit_shed
	$pantry.add_item(shedkey)
	
	var exit_backdoor = $backdoor.connect_exits_locked("outside", $behind_inn, "inside")
	var backdoorkey = load_item("backdoor_key")
	backdoorkey.use_value = exit_backdoor


func load_item(item_name: String):
	return load("res://items/" + item_name + ".tres")


func load_character(character_name: String):
	return load("res://characters/" + character_name + ".tres")
