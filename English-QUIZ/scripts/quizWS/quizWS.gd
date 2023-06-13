extends CanvasLayer

export (NodePath) var perguntaPath
export (NodePath) var lastScorePath
export (NodePath) var bestScorePath
export (NodePath) var buttonAPath
export (NodePath) var buttonBPath
export (NodePath) var buttonCPath
export (NodePath) var buttonDPath
export (NodePath) var questionsPath
export (NodePath) var answerPath

onready var pergunta = get_node(perguntaPath)
onready var lastScore = get_node(lastScorePath)
onready var bestScore = get_node(bestScorePath)
onready var buttonA = get_node(buttonAPath)
onready var buttonB = get_node(buttonBPath)
onready var buttonC = get_node(buttonCPath)
onready var buttonD = get_node(buttonDPath)
onready var questions = get_node(questionsPath)
onready var answer = get_node(answerPath)

var cadaQuestao
var score = 0

var acertos = 0
var erros = 0

var n1 = 0
var acabouPoha = 0

var opaQuestaoN = 0

var respLETRA

func _ready():
	randomize()
	buttonA.set_text("")
	buttonB.set_text("")
	buttonC.set_text("")
	buttonD.set_text("")
	setarPergunta()
	lastScore.set_text(str(0))
	bestScore.set_text(str(game.best_score))
	n1 = (10.0/questions.get_child_count())


func setarPergunta():
	if acabouPoha == 1:
		$HTTPRequest.request("http://localhost/quiz/api/perguntas")
		if score > game.best_score:
				game.best_score = score
				bestScore.set_text(str(game.best_score))
		$backAnswer.show()
		$backAnswer/anime.play("backVEM")
		var nota = (n1 * acertos)
		answer.set_text("O TEMPO ACABOU! SUA NOTA: " +  str(int(nota)))
		$backAnswer/continuar.hide()
		$backAnswer/reiniciar.show()
		print("wow bitch")
	else:
		var todasQuestions = questions.get_child_count()
		if todasQuestions > 0:
			opaQuestaoN += 1
			cadaQuestao = questions.get_child(randi() % todasQuestions)
			pergunta.set_text(cadaQuestao.get("pergunta"))
			$botoes/buttonA/aButton.set_text("A) " + cadaQuestao.get("opcaoA"))
			$botoes/buttonB/bButton.set_text("B) " + cadaQuestao.get("opcaoB"))
			$botoes/buttonC/cButton.set_text("C) " + cadaQuestao.get("opcaoC"))
			$botoes/buttonD/dButton.set_text("D) " + cadaQuestao.get("opcaoD"))
			$pergunta/opaQuestao.set_text(str(opaQuestaoN, "/", questions.get_child_count()))
		else:
			pergunta.set_text("Não há mais perguntas, sua pontuação: " + str(score))
			buttonA.set_text("A")
			buttonB.set_text("B")
			buttonC.set_text("C")
			buttonD.set_text("D") 
			buttonA.disabled = true
			buttonB.disabled = true
			buttonC.disabled = true
			buttonD.disabled = true
			if score > game.best_score:
				game.best_score = score
				bestScore.set_text(str(game.best_score))
			$backAnswer.show()
			$backAnswer/anime.play("backVEM")
			var nota = (n1 * acertos)
			answer.set_text("REINICIAR QUIZ, SUA NOTA: " +  str(int(nota)))
			$backAnswer/continuar.hide()
			$backAnswer/reiniciar.show()
		
		
		if cadaQuestao != null:
			questions.remove_child(cadaQuestao)
		
func _on_HTTPRequest_request_completed( result, response_code, headers, body ):
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result, "wow")
	

func answerbitch():
	if cadaQuestao.get("trueA") == true:
		respLETRA = "A"
	elif cadaQuestao.get("trueB") == true:
		respLETRA = "B"
	elif cadaQuestao.get("trueC") == true:
		respLETRA = "C"
	elif cadaQuestao.get("trueD") == true:
		respLETRA = "D"
		

func _on_buttonA_pressed():
	$backAnswer.show()
	$backAnswer/anime.play("backVEM")
	if cadaQuestao.get("trueA") == true:
		answer.set_text("ESTÁ CORRETO! " + cadaQuestao.get("explicaTRUE"))
		$correct.play()
		score += 10
		acertos += 1
		lastScore.set_text(str(score))
	else:
		answerbitch()
		answer.set_text("ERRADO!! CORRETA: " + respLETRA)
		$wrong.play()
		score -= 5
		erros +=1
		lastScore.set_text(str(score))
		

func _on_buttonB_pressed():
	$backAnswer.show()
	$backAnswer/anime.play("backVEM")
	if cadaQuestao.get("trueB") == true:
		answer.set_text("ESTÁ CORRETO! " + cadaQuestao.get("explicaTRUE"))
		score += 10
		acertos += 1
		lastScore.set_text(str(score))
	else:
		answerbitch()
		answer.set_text("ERRADO!! CORRETA: " + respLETRA)
		score -= 5
		$wrong.play()
		erros +=1
		lastScore.set_text(str(score))


func _on_buttonC_pressed():
	$backAnswer.show()
	$backAnswer/anime.play("backVEM")
	if cadaQuestao.get("trueC") == true:
		answer.set_text("ESTÁ CORRETO! " + cadaQuestao.get("explicaTRUE"))
		$correct.play()
		score += 10
		acertos += 1
		lastScore.set_text(str(score))
	else:
		answerbitch()
		answer.set_text("ERRADO!! CORRETA: " + respLETRA)
		score -= 5
		$wrong.play()
		erros +=1
		lastScore.set_text(str(score))


func _on_buttonD_pressed():
	$backAnswer.show()
	$backAnswer/anime.play("backVEM")
	if cadaQuestao.get("trueD") == true:
		answer.set_text("ESTÁ CORRETO! " + cadaQuestao.get("explicaTRUE"))
		$correct.play()
		score += 10
		acertos += 1
		lastScore.set_text(str(score))
	else:
		answerbitch()
		answer.set_text("ERRADO!! CORRETA: " + respLETRA)
		score -= 5
		$wrong.play()
		erros +=1
		lastScore.set_text(str(score))


func _on_continuar_pressed():
	$backAnswer/anime.play("backFOI")
	setarPergunta()
	$backAnswer.hide()
	
	
func _on_reiniciar_pressed():
	get_tree().reload_current_scene()
	

func _on_timer_acabouVei():
	acabouPoha = 1
	
#func TMinutes():
#	if acabouPoha == 1:
#		if score > game.best_score:
#				game.best_score = score
#				bestScore.set_text(str(game.best_score))
#		$backAnswer.show()
#		$backAnswer/anime.play("backVEM")
#		var nota = (n1 * acertos)
#		answer.set_text("O TEMPO ACABOU! SUA NOTA: " +  str(int(nota)))
#		$backAnswer/continuar.hide()
#		$backAnswer/reiniciar.show()
#		print("wow bitch")


func _on_voltar_pressed():
	get_tree().change_scene("res://scenes/menu.tscn")
