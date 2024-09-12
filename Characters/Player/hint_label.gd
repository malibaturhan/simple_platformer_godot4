extends Label

var hint_text: String:
	set(val):
		hint_text = val
		text = hint_text
		print("label text is changed")
	get:
		return hint_text
		
func _ready() -> void:
	self.visible = false
	
func show_hint_label():
	print("hint label is visible now")
	self.visible = true
	
func hide_hint_label():
	self.visible = false
