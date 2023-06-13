extends CanvasLayer

var acertos = 10.0
var nota = 0.0

func _ready():
	nota = ((10.0/14.0)*acertos)
	print(int(nota))

func _on_sair_pressed():
	get_tree().quit()

func _on_continuar_pressed():
	if game.best_score > 0:
		get_tree().change_scene("res://scenes/quizWS.tscn")
	else:
		$continuar.disabled = true

func _on_redirect_liguee():
	OS.shell_open("https://www.linguee.com.br/")

func _on_novoJogo_pressed():
	if game.best_score >= 0:
		game.best_score = 0
		get_tree().change_scene("res://scenes/quizWS.tscn")


func _on_continuar_visibility_changed():
	pass # Replace with function body.


func _on_back_item_rect_changed():
	pass # Replace with function body.
