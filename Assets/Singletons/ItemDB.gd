extends Node

var another = ""
var ICON_PATH = ""
var ITEMS = {}
func _ready():
	if LoadAndSave.data.options.alternative_color_mode:
		another = "another_"
	print(another)
	ICON_PATH = "res://Assets/Sprites/Boxes/"+another
	ITEMS = {
	"vowel": {
		"icon": ICON_PATH +"vowel.png",
		"slot": "one_slot"
	},
	"soft_consonant": {
		"icon": ICON_PATH + "breastplate.png",
		"slot": "one_slot"
	},
	"solid_consonant": {
		"icon": ICON_PATH + "solid_consonant.png",
		"slot": "one_slot"
	},
	"soft_consonant_vowel": {
		"icon": ICON_PATH + "soft_consonant_vowel.png",
		"slot": "two_slot"
	},
	"solid_consonant_vowel": {
		"icon": ICON_PATH + "solid_consonant_vowel.png",
		"slot": "two_slot"
	}
}
