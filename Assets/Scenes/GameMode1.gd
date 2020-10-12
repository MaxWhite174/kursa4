extends Node2D

var letter
var lvl_number

var soft_consonant_vowel
var solid_consonant_vowel
var soft
var solid
var word_answer
var array_all = []
var data = {}



func loading_data():
	var dict = {}
	var file = File.new()
	var path_data = "res://Assets/Resources/Levels/gamemode1.json"
	file.open(path_data, file.READ)
	var text = file.get_as_text()
	dict = parse_json(text)
	file.close()
	return dict["quests"][0]

func checking_alt_colors():
	if LoadAndSave.data.options.alternative_color_mode:
		$MainControl/Control3/ColorRect/OptionHBox/TextureRect2.texture_normal = load("res://Assets/Sprites/Boxes/another_soft_consonant.png")
		$MainControl/Control3/ColorRect/OptionHBox/TextureRect3.texture_normal = load("res://Assets/Sprites/Boxes/another_soft_consonant_vowel.png")
		$MainControl/Control3/ColorRect/OptionHBox/TextureRect4.texture_normal = load("res://Assets/Sprites/Boxes/another_solid_consonant.png")
		$MainControl/Control3/ColorRect/OptionHBox/TextureRect5.texture_normal = load("res://Assets/Sprites/Boxes/another_solid_consonant_vowel.png")

func _ready():
	randomize()
	checking_alt_colors()
	var _data = loading_data()
	letter = G.letter
	lvl_number = G.tmp_level
	start(_data)
	
func start(_data):
	data = _data
	var lvl = data[letter]
	soft_consonant_vowel = lvl.soft_consonant_vowel.duplicate(true)
	solid_consonant_vowel = lvl.solid_consonant_vowel.duplicate(true)
	if lvl.has("soft"):
		soft = lvl.soft
		array_all.append(soft)
	if lvl.has("solid"):
		solid = lvl.solid
		array_all.append(solid)
	array_all+=soft_consonant_vowel+solid_consonant_vowel
	array_all.shuffle()
	create_level(array_all.pop_back())
	

func create_level(lvl):
	$MainControl/Control/ColorRect/Label.text = lvl
	word_answer = lvl


func _on_Answer_Button_pressed(answer):
	var _answer = ""
	if word_answer == soft:
		_answer = "soft"
	elif word_answer == solid:
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
			LoadAndSave.data.player.mod1.levels_complete.append(lvl_number)
			LoadAndSave.save_data()
			get_tree().change_scene("res://Assets/Scenes/MainMap.tscn")
		
	else:
		$MainControl/AnimationPlayer.play("bad")
		
	#if answer in 


func _on_HUD_back():
	get_tree().change_scene("res://Assets/Scenes/MainMap.tscn")


func _on_HUD_help():
	pass # Replace with function body.
