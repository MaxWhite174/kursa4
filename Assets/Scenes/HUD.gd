extends CanvasLayer

signal help
signal back

func _ready():
	pass


func _on_back_pressed():
	emit_signal("back")


func _on_help_pressed():
	$AcceptDialog.popup()
	emit_signal("help")
	
