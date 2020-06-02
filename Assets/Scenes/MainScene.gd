extends Node2D



func _ready():
	$Control/ColorRect2/ColorRect3/ScrollContainer/VBoxContainer/PanelContainer/CheckButton.pressed = LoadAndSave.data.options.alternative_color_mode


func _on_Button_pressed():
	get_tree().change_scene("res://Assets/Scenes/Difficult.tscn")


func _on_Button_MAP_pressed():
	 get_tree().change_scene("res://Assets/Scenes/MainMap.tscn")
	


func _on_Settings_pressed():
		$Control/ColorRect2.show()


func _on_Button_Close_Setting_pressed():
	$Control/ColorRect2.hide()



	


func _on_CheckButton_pressed():
	LoadAndSave.data.options.alternative_color_mode = !LoadAndSave.data.options.alternative_color_mode
	LoadAndSave.save_data()
