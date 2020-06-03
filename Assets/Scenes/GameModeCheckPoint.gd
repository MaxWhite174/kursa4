extends Node2D

var letters
var lvl_number

var soft_consonant_vowel = []
var solid_consonant_vowel = []
var soft = []
var solid = []
var word_answer
var array_all = []
var data = {}



func loading_data():
	var dict = {}
	var file = File.new()
	var path_data = "res://gm2_data/gamemode1.json"
	file.open(path_data, file.READ)
	var text = file.get_as_text()
	dict = parse_json(text)
	file.close()
	return dict["quests"][0]

func _ready():
	randomize()
	var _data = loading_data()
	letters = G.letters
	lvl_number = G.tmp_level
	start(_data)
	
func start(_data):
	data = _data
	for letter in letters:
		var lvl = data[letter]
		
		soft_consonant_vowel+= lvl.soft_consonant_vowel.duplicate(true)
		solid_consonant_vowel+= lvl.solid_consonant_vowel.duplicate(true)
		
		if lvl.has("soft"):
			soft.append(lvl.soft)
		if lvl.has("solid"):
			solid.append(lvl.solid)
		
	array_all+=soft_consonant_vowel+solid_consonant_vowel+solid+soft
	array_all.shuffle()
	
	create_level(array_all.pop_back())
	

func create_level(lvl):
	$MainControl/Control/ColorRect/Label.text = lvl
	word_answer = lvl


func _on_Answer_Button_pressed(answer):
	var _answer = ""
	if word_answer in soft:
		_answer = "soft"
	if word_answer in solid:
		_answer = "solid"
	if word_answer in solid_consonant_vowel:
		_answer = "solid_consonant_vowel"

	if word_answer in soft_consonant_vowel:
		_answer = "soft_consonant_vowel"
	if answer == _answer:
		$MainControl/AnimationPlayer.play("good")
		if array_all.size()>0:
			create_level(array_all.pop_back())
		else:
			if not lvl_number in LoadAndSave.data.player.mod1.levels_complete:
				LoadAndSave.data.player.mod1.levels_complete.append(lvl_number)
			LoadAndSave.save_data()
			get_tree().change_scene("res://MainMap.tscn")
		
	else:
		$MainControl/AnimationPlayer.play("bad")


func _on_HUD_back():
	get_tree().change_scene("res://MainMap.tscn")


func _on_HUD_help():
	pass # Replace with function body.
