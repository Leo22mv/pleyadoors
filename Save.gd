extends Node


const savefile = "user://SAVEFILE.save"
const savefile2 = "user://SAVEFILE2.save"
const savefile3 = "user://SAVEFILE3.save"
const slotsavefile = "user://SLOTFILE.save"

var actualSlot
var actualSlotBackup

var game_data = {
	"player" : {
		"color" : "red",
		"face" : 1,
		"position" : {
			"x" : 288,
			"y" : 768
		},
		"hp" : {
			"cur" : 3,
			"max" : 3
		},
		"gems" : 0,
		"keys" : {
			"red" : 0,
			"green" : 0,
			"golden" : 0
		},
		"unlockeddoors" : [],
		"isonship" : false,
		"unlocked_upgrades": []
	},
	"world" : [
	{
		"name" : "level_2",
		"node_name" : "Level2",
		"collected_gems" : [],
		"collected_keys": [],
		"destroyed_walls": []
	},
	{
		"name" : "level_2.1",
		"node_name" : "Level2_1",
		"collected_keys": [],
		"collected_gems": []
	},
	{
		"name" : "level_1",
		"node_name" : "Level1",
		"collected_keys": [],
		"destroyed_walls": []
	},
	{
		"name" : "world_1",
		"node_name" : "World1",
		"collected_keys": [],
		"unlocked_teleporters": []
	},
	{
		"name" : "world_1.1",
		"node_name" : "World1_1",
		"collected_gems": [],
		"collected_keys": [],
		"unlocked_teleporters": [],
		"destroyed_walls": []
	},
	{
		"name" : "world_1.1.1",
		"node_name" : "World1_1_1",
		"collected_gems": [],
		"collected_keys": [],
	},
	{
		"name" : "world_1.1.2",
		"node_name" : "World1_1_2",
		"collected_gems": [],
		"collected_keys": [],
	},
	{
		"name" : "world_1.2",
		"node_name" : "World1_2",
		"collected_gems": [],
		"collected_keys": [],
		"unlocked_teleporters": []
	},
	{
		"name" : "world_1.2.1",
		"node_name" : "World1_2_1",
		"collected_gems": [],
		"collected_keys": [],
		"unlocked_teleporters": []
	},
	{
		"name" : "world_1.2.2",
		"node_name" : "World1_2_2",
		"collected_gems": [],
		"collected_keys": [],
		"unlocked_teleporters": []
	},
	{
		"name" : "world_1.3",
		"node_name" : "World1_3",
		"collected_gems": [],
		"collected_keys": [],
		"unlocked_teleporters": []
	},
	{
		"name" : "world_1.3.1",
		"node_name" : "World1_3_1",
		"collected_gems": [],
		"collected_keys": [],
		"unlocked_teleporters": []
	},
	{
		"name" : "world_1.3.2",
		"node_name" : "World1_3_2",
		"collected_gems": [],
		"collected_keys": [],
		"unlocked_teleporters": []
	}
	],
	"actualworld" : "level_1",
	"actualworldcoords" : [288, 768],
	"ship" : {
		"position" : {
			"x": 4896,
			"y" : 760
		}
	},
	"actual_planet": "tutorial"
}

var empty_game_data = {
	"player" : {
		"color" : "red",
		"face" : 1,
		"position" : {
			"x" : 288,
			"y" : 768
		},
		"hp" : {
			"cur" : 3,
			"max" : 3
		},
		"gems" : 0,
		"keys" : {
			"red" : 0,
			"green" : 0,
			"golden" : 0
		},
		"unlockeddoors" : [],
		"isonship" : false,
		"unlocked_upgrades": []
	},
	"world" : [
	{
		"name" : "level_2",
		"node_name" : "Level2",
		"collected_gems" : [],
		"collected_keys": [],
		"destroyed_walls": []
	},
	{
		"name" : "level_2.1",
		"node_name" : "Level2_1",
		"collected_keys": [],
		"collected_gems": []
	},
	{
		"name" : "level_1",
		"node_name" : "Level1",
		"collected_keys": [],
		"destroyed_walls": []
	},
	{
		"name" : "world_1",
		"node_name" : "World1",
		"collected_keys": [],
		"unlocked_teleporters": []
	},
	{
		"name" : "world_1.1",
		"node_name" : "World1_1",
		"collected_gems": [],
		"collected_keys": [],
		"unlocked_teleporters": [],
		"destroyed_walls": []
	},
	{
		"name" : "world_1.1.1",
		"node_name" : "World1_1_1",
		"collected_gems": [],
		"collected_keys": [],
	},
	{
		"name" : "world_1.1.2",
		"node_name" : "World1_1_2",
		"collected_gems": [],
		"collected_keys": [],
	},
	{
		"name" : "world_1.2",
		"node_name" : "World1_2",
		"collected_gems": [],
		"collected_keys": [],
		"unlocked_teleporters": []
	},
	{
		"name" : "world_1.2.1",
		"node_name" : "World1_2_1",
		"collected_gems": [],
		"collected_keys": [],
		"unlocked_teleporters": []
	},
	{
		"name" : "world_1.2.2",
		"node_name" : "World1_2_2",
		"collected_gems": [],
		"collected_keys": [],
		"unlocked_teleporters": []
	},
	{
		"name" : "world_1.3",
		"node_name" : "World1_3",
		"collected_gems": [],
		"collected_keys": [],
		"unlocked_teleporters": []
	},
	{
		"name" : "world_1.3.1",
		"node_name" : "World1_3_1",
		"collected_gems": [],
		"collected_keys": [],
		"unlocked_teleporters": []
	},
	{
		"name" : "world_1.3.2",
		"node_name" : "World1_3_2",
		"collected_gems": [],
		"collected_keys": [],
		"unlocked_teleporters": []
	}
	],
	"actualworld" : "level_1",
	"actualworldcoords" : [288, 768],
	"ship" : {
		"position" : {
			"x": 4896,
			"y" : 760
		}
	},
	"actual_planet": "tutorial"
}

func _ready():
#	match actualSlot:
#		1:
#			load_data()
	pass

func save_data():
	match actualSlot:
		1:
			var file = FileAccess.open(savefile, FileAccess.WRITE)
			file.store_var(game_data)
			file = null
		2:
			var file = FileAccess.open(savefile2, FileAccess.WRITE)
			file.store_var(game_data)
			file = null
		3:
			var file = FileAccess.open(savefile3, FileAccess.WRITE)
			file.store_var(game_data)
			file = null
	
#	var file = FileAccess.open(slotsavefile, FileAccess.WRITE)
#	file.store_var(actualSlot)
#	file = null

func load_data():
	match actualSlot:
		1:
			var file = FileAccess.open(savefile, FileAccess.READ)
			if file != null:
				game_data = file.get_var()
			save_data()
			file = null
		2:
			var file = FileAccess.open(savefile2, FileAccess.READ)
			if file != null:
				game_data = file.get_var()
			save_data()
			file = null
		3:
			var file = FileAccess.open(savefile3, FileAccess.READ)
			if file != null:
				game_data = file.get_var()
			save_data()
			file = null
	
#	var file = FileAccess.open(slotsavefile, FileAccess.READ)
#	file.get_var(actualSlot)
#	save_data()
#	file = null

func verifyFileExistence():
	match actualSlot:
		1:
			return FileAccess.file_exists(savefile)
			
		2:
			return FileAccess.file_exists(savefile2)
			
		3:
			return FileAccess.file_exists(savefile3)

func save_actual_slot():
	var file = FileAccess.open(slotsavefile, FileAccess.WRITE)
	file.store_var(actualSlot)
	file = null


func load_actual_slot():
	var file = FileAccess.open(slotsavefile, FileAccess.READ)
	file.get_var(actualSlot)
	save_actual_slot()
	file = null
