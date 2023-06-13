extends RichTextLabel

signal acabouVei
var ms = 0
var s = 0
var m = 0

func _process(delta):
	
	if ms > 09:
		s += 01
		ms = 00
		
	if s > 59:
		m += 01
		s = 00
		
	set_text(str(m)+":"+str(s)+":"+str(ms))
	
	pass

func _on_tms_timeout():
	ms += 1
	
	if m >= 3:
		emit_signal("acabouVei")
		ms = 0
