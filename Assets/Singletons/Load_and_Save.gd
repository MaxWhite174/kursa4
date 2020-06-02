extends Node

var default_data = {
	"player":{
		"mod1":{
			"levels_complete": [] 
		},
		"mod2":{
			"last_score": [0,0,0],
			"best_score" : [0,0,0]
		}
	},
	"options" : {
	"music_volume" : 0.5,
	"alternative_color_mode" : false,
	"debug_mode" : false
	}
}

var path = "res://Assets/Resources/Data/User_data.json"
var data = {}

func _ready():
	load_data()

func load_data():
	var file = File.new()
	
	if not file.file_exists(path):
		reset_data()
		return
	file.open(path,file.READ)
	var text = file.get_as_text()
	data = parse_json(text)
	file.close()
		
func save_data():
	var file = File.new()
	file.open(path,file.WRITE)
	file.store_line(to_json(data))
	file.close()
		
func reset_data():
	data = default_data.duplicate(true)
	save_data()
