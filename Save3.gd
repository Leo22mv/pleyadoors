extends Node


const savefile = "user://SAVEFILE3.save"

var game_data = {
	"player" : {
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
			"green" : 0
		},
		"unlockeddoors" : [],
		"isonship" : false
	},
	"world" : [
	{
		"name" : "level_2",
		"uncollected_gems" : ["Gem", "Gem2", "Gem3", "Gem4", "Gem5", "Gem6", "Gem7", "Gem8", "Gem9", "Gem10"]
	},
	{
		"name" : "level_2.1",
		"uncollected_gems" : []
	}
	],
	"actualworld" : "level_1",
	"actualworldcoords" : [288, 768],
	"ship" : {
		"position" : {
			"x": 2336,
			"y" : 760
		}
	}
}

func _ready():
#	load_data()
	pass

func save_data():
	var file = FileAccess.open(savefile, FileAccess.WRITE)
	file.store_var(game_data)
	file = null

func load_data():
	var file = FileAccess.open(savefile, FileAccess.READ)
	if file == null:
		save_data()
	else:
		game_data = file.get_var()
	save_data()
	file = null

func verifyFileExistence():
	var file = FileAccess.open(savefile, FileAccess.READ)
	if file == null:
		return true
