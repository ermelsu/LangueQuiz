extends Node

export(Resource) var bd_quiz
export(Color) var color_right
export(Color) var color_wrong

var buttons := []
var index := 0

func _ready() -> void:
	for _button in $question_holder.get_children():
		buttons.append(_button)
