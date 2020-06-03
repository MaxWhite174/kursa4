extends Node2D

var levels_complete
var start_lvl = [1,2,3]
onready var lvl_data = {
	1:{
		"letter" : "Б",
		"node" : $ScrollContainer/Control/Sprite/Control/Button4
	},
	2:{
		"letter" : "В",
		"node" : $ScrollContainer/Control/Sprite/Control/Button3
	},
	3:{
		"letter" : "Г",
		"node" : $ScrollContainer/Control/Sprite/Control/Button2
	},
	4:{
		"letters" : ["Б","В","Г"],
		"time" : 60,
		"node" : $ScrollContainer/Control/Sprite/Control/Button,
		"node_texture" : $ScrollContainer/Control/Sprite/Control/Button/TextureRect
	},
	5:{
		"letter" : "Д",
		"node" : $ScrollContainer/Control/Sprite/Control2/Button4
	},
	6:{
		"letter" : "Ж",
		"node" : $ScrollContainer/Control/Sprite/Control2/Button3
	},
	7:{
		"letter" : "З",
		"node" : $ScrollContainer/Control/Sprite/Control2/Button2
	},
	8:{
		"letters" : ["Б","В","Г","Д","Ж","З"],
		"time" : 90,
		"node" : $ScrollContainer/Control/Sprite/Control2/Button,
		"node_texture" : $ScrollContainer/Control/Sprite/Control2/Button/TextureRect,
	},
	9:{
		"letter" : "Й",
		"node" : $ScrollContainer/Control/Sprite/Control3/Button4
	},
	10:{
		"letter" : "К",
		"node" : $ScrollContainer/Control/Sprite/Control3/Button3
	},
	11:{
		"letter" : "Л",
		"node" : $ScrollContainer/Control/Sprite/Control3/Button2
	},
	12:{
		"letters" : ["Б","В","Г","Д","Ж","З","Й","К","Л"],
		"time" : 120,
		"node" : $ScrollContainer/Control/Sprite/Control3/Button,
		"node_texture" : $ScrollContainer/Control/Sprite/Control3/Button/TextureRect,
	},
	13:{
		"letter" : "М",
		"node" : $ScrollContainer/Control/Sprite/Control4/Button4
	},
	14:{
		"letter" : "Н",
		"node" : $ScrollContainer/Control/Sprite/Control4/Button3
	},
	15:{
		"letter" : "П",
		"node" : $ScrollContainer/Control/Sprite/Control4/Button2
	},
	16:{
		"letters" : ["Б","В","Г","Д","Ж","З","Й","К","Л","М","Н","П"],
		"time" : 150,
		"node" : $ScrollContainer/Control/Sprite/Control4/Button,
		"node_texture" : $ScrollContainer/Control/Sprite/Control4/Button/TextureRect,
	},
	17:{
		"letter" : "Р",
		"node" : $ScrollContainer/Control/Sprite/Control5/Button4
	},
	18:{
		"letter" : "С",
		"node" : $ScrollContainer/Control/Sprite/Control5/Button3
	},
	19:{
		"letter" : "Т",
		"node" : $ScrollContainer/Control/Sprite/Control5/Button2
	},
	20:{
		"letters" : ["Б","В","Г","Д","Ж","З","Й","К","Л","М","Н","П","Р","С","Т"],
		"time" : 180,
		"node" : $ScrollContainer/Control/Sprite/Control5/Button,
		"node_texture" : $ScrollContainer/Control/Sprite/Control5/Button/TextureRect,
	},
	21:{
		"letter" : "Ф",
		"node" : $ScrollContainer/Control/Sprite/Control6/Button4
	},
	22:{
		"letter" : "Х",
		"node" : $ScrollContainer/Control/Sprite/Control6/Button3
	},
	23:{
		"letter" : "Ц",
		"node" : $ScrollContainer/Control/Sprite/Control6/Button2,
	},
	24:{
		"letters" : ["Б","В","Г","Д","Ж","З","Й","К","Л","М","Н","П","Р","С","Т","Ф","Х","Ц"],
		"time" : 210,
		"node" : $ScrollContainer/Control/Sprite/Control6/Button,
		"node_texture" : $ScrollContainer/Control/Sprite/Control6/Button/TextureRect,
	},
	25:{
		"letter" : "Ч",
		"node" : $ScrollContainer/Control/Sprite/Control7/Button4,
	},
	26:{
		"letter" : "Ш",
		"node" : $ScrollContainer/Control/Sprite/Control7/Button3,
	},
	27:{
		"letter" : "Щ",
		"node" : $ScrollContainer/Control/Sprite/Control7/Button2,
	},
	28:{
		"letters" : ["Б","В","Г","Д","Ж","З","Й","К","Л","М","Н","П","Р","С","Т","Ф","Х","Ц","Ч","Ш","Щ"],
		"time" : 240,
		"node" : $ScrollContainer/Control/Sprite/Control7/Button,
		"node_texture" : $ScrollContainer/Control/Sprite/Control7/Button/TextureRect,
	}
}

func _ready():
	levels_complete = LoadAndSave.data.player.mod1.levels_complete
	#for id in levels_complete:
		#lvl_data[id]
	button_disabler()
	button_check_point_availbler()
	button_painter()	

func button_disabler():
	var lvl = 1
	while lvl <= lvl_data.size():
		if not (lvl in levels_complete) and not (lvl in start_lvl):
			
			lvl_data[lvl].node.disabled = true
			lvl+=1
		elif lvl%4==0 and lvl in levels_complete:
			
			lvl_data[lvl+3].node.disabled = false
			lvl_data[lvl+2].node.disabled = false
			lvl_data[lvl+1].node.disabled = false
			lvl+=4
		else:
			lvl+=1
		


func button_painter():
	for id in levels_complete:
		lvl_data[int(id)].node.add_color_override("font_color", Color(0.13, 0.55, 0.13, 1))

func button_check_point_availbler():
	var _tmp_lvl_arr =[]
	for lvl in lvl_data:
		if !lvl%4==0:
			if lvl in levels_complete:
				_tmp_lvl_arr.append(lvl)
		else:
			if _tmp_lvl_arr.size() == 3:
				lvl_data[lvl].node_texture.hide()
				lvl_data[lvl].node.disabled = false
				_tmp_lvl_arr.clear()

func _on_Letter_Button_pressed(id):
	if id%4==0:
		G.lvl_data = lvl_data
		G.tmp_level = id
		G.letters = lvl_data[id].letters
		get_tree().change_scene("res://Assets/Scenes/GameModeCheckPoint.tscn")
		
	else:
		G.letter = lvl_data[id].letter
		G.tmp_level = id
		get_tree().change_scene("res://Assets/Scenes/GameMode1.tscn")



func _on_HUD_back():
	get_tree().change_scene("res://Assets/Scenes/MainScene.tscn")
