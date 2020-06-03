extends Node2D
var box_scene = preload("res://Assets/Scenes/ItemBox.tscn")
onready var OptionHBox = $MainControl/Control3/ColorRect/OptionHBox
onready var AnswerHBox = $MainControl/Control2/ColorRect/AnswerHBox
var arr_answers : Array = []
var arr_variant : Array = []
var quest_answer = []
var score = 0
var arr_level = []
var lvl_now = "1"
var lvl_max
var data = {}

var difficult

func loading_data(difficult):
	var dict = {}
	var file = File.new()
	var path_data = "res://Assets/Resources/Levels/gamemode2_%d.json" % difficult
	file.open(path_data, file.READ)
	var text = file.get_as_text()
	dict = parse_json(text)
	file.close()
	return dict["quests"][0]

func _ready():
	randomize()
	difficult = G.tmp_difficult
	var _data = loading_data(difficult)
	start(_data)
	
func start(_data):
	data = _data
	arr_level = data.keys()
	lvl_now = "1"
	lvl_max = arr_level[-1]
	create_level()
	

func create_level(lvl="1"):
	var quest = data[lvl]
	quest_answer = quest.answer.duplicate()
	#quest_answer.append(quest["answer"])
	$MainControl/Control/ColorRect/Label.text = quest.word
	for icon in quest.boxes:
		var item = box_scene.instance()
		item.texture = load("res://Assets/Sprites/Boxes/%s.png" % icon)
		item.title = "Answer"
		
		if icon.ends_with("one_slot"):
			item.slot = "one_slot"
		if icon.ends_with("two_slot"):
			item.slot = "two_slot"
		item.name = "Answer"
		item.stretch_mode =TextureRect.STRETCH_KEEP_CENTERED		
		AnswerHBox.add_child(item)
		arr_answers.append(item)
	
	var arr_boxes = ["vowel","soft_consonant","solid_consonant","soft_consonant_vowel","solid_consonant_vowel"]
	var count_answers : int = quest.answer.size()
	var len_boxes = 6
	var rand_size =  len_boxes - count_answers
	var answer_arr : Array = quest.answer
	for i_box in range(len_boxes):
		var tmp = null		
		if answer_arr.size() > 0:
			var rnd = (randi() % 2)
			if rnd:
				tmp = answer_arr.pop_back()
			else:
				tmp = answer_arr.pop_front()
		else:
			var rnd = (randi() % 2)
			if rnd:
				tmp = arr_boxes.pop_back()
			else:
				tmp = arr_boxes.pop_front()
		var item_answ = box_scene.instance()
		var box_answ = ItemDB.ITEMS[tmp]
		item_answ.texture = load(box_answ.icon)
		item_answ.title = "Variant"
		item_answ.slot = box_answ.slot
		item_answ.answer = tmp
		item_answ.name = "Variant%d" % i_box
		item_answ.stretch_mode =TextureRect.STRETCH_KEEP_CENTERED
		OptionHBox.add_child(item_answ)
		arr_variant.append(item_answ)
			
func level_continue():
	quest_answer.clear()
	for noda in arr_answers:
		noda.hide()
		noda.queue_free()
	for noda in arr_variant:
		noda.hide()
		noda.queue_free()
	arr_answers.clear()
	arr_variant.clear()
	var lvl_next = arr_level[arr_level.find(lvl_now)+1]

	if int(lvl_max) <= int(lvl_next):
		create_level(lvl_next)
	else:
		get_tree().change_scene("res://Assets/Scenes/Difficult.tscn")
	

func _on_Go_Button_pressed():
	for item in arr_answers:
		if item:
			if item.answer in quest_answer:
				score+=1
	$MainControl/ColorRect/Label.text= "Score : %d" % score
	level_continue()
	
	


func _on_Reset_Button_pressed():
	pass


func _on_HUD_back():
	get_tree().change_scene("res://Assets/Scenes/Difficult.tscn")


func _on_HUD_help():
	pass # Replace with function body.
