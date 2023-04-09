extends Node


func _ready() -> void:
	$behind_inn.connect_exits_unlocked("alley", $street_3, "alley")
	var exit_shed = $behind_inn.connect_exits_locked("shed", $shed, "backyard")
	
	var sword = load_item("guard_sword")
	$shed.add_item(sword)
	
	var guard = load_character("guard")
	var coins = load_item("coins")
	guard.quest_reward = coins
	$city_gate.add_character(guard)
	$city_gate.connect_exits_unlocked("east", $street_1)
	
	$street_1.connect_exits_unlocked("east", $street_2)
	
	$street_2.connect_exits_unlocked("east", $street_3)
	
	$street_3.connect_exits_unlocked("east", $street_4)
	
	$street_4.connect_exits_unlocked("east", $street_5)
	$street_4.connect_exits_unlocked("inn", $taproom, "street")
	
	$street_5.connect_exits_unlocked("east", $street_6)
	
	$street_6.connect_exits_unlocked("east", $street_7)
	
	$street_7.connect_exits_unlocked("east", $street_8)
	
	var innkeeper = load_character("innkeeper")
	var room_key = load_item("room_key")
	innkeeper.quest_reward = room_key
	$taproom.add_character(innkeeper)
	$taproom.connect_exits_unlocked("stairs", $stairs, "taproom")
	$taproom.connect_exits_unlocked("kitchen", $kitchen, "taproom")
	
	$stairs.connect_exits_unlocked("down", $cellar)
	$stairs.connect_exits_unlocked("up", $upstairs_hallway)
	
	$upstairs_hallway.connect_exits_unlocked("left", $room_1, "hallway")
	var exit_room = $upstairs_hallway.connect_exits_locked("right", $room_2, "hallway")
	room_key.use_value = exit_room
	
	$room_2.connect_exits_unlocked("bed", $bed, "up")
	
	var cook = load_character("cook")
	var backdoor_key = load_item("backdoor_key")	
	$kitchen.add_character(cook)
	$kitchen.add_item(backdoor_key)
	$kitchen.connect_exits_unlocked("pantry", $pantry, "kitchen")
	var exit_backdoor = $kitchen.connect_exits_locked("backyard", $behind_inn, "door")
	var backdoorkey = load_item("backdoor_key")
	backdoorkey.use_value = exit_backdoor
	
	var shedkey = load_item("shed_key")
	shedkey.use_value = exit_shed
	$pantry.add_item(shedkey)


func load_item(item_name: String):
	return load("res://items/" + item_name + ".tres")


func load_character(character_name: String):
	return load("res://characters/" + character_name + ".tres")
