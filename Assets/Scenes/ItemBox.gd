extends TextureRect

var title
var slot
var tmp_slot
var answer

func _ready():
	pass
	
func get_drag_data(_pos):
	if self.title == "Variant":
		print(self.slot)
		# Use another colorpicker as drag preview
		var cpb = TextureRect.new()
		cpb.texture = texture
		cpb.rect_size = Vector2(50, 50)
		cpb.rect_pivot_offset = cpb.rect_size/2
		set_drag_preview(cpb)
		# Return color as drag data
		return [texture, self.slot, self]
	else:
		return null


func can_drop_data(_pos, data):
	return typeof(data) == 19


func drop_data(_pos, data):
	if self.title == "Answer" and slot == data[1]:
		texture = data[0]
		data[2].hide()
		answer = data[2].answer
	else:
		return null
