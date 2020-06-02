extends Node2D


func _ready():
	$HUD/TextureButton2.hide()


func _on_Difficult_Button_pressed(lvl_dif):
	G.tmp_difficult = lvl_dif
	get_tree().change_scene("res://Assets/Scenes/GameMode2.tscn")


func _on_HUD_back():
	get_tree().change_scene("res://Assets/Scenes/MainScene.tscn")
