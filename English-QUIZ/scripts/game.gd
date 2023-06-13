extends Node

const FILE_PATH = "user://save.data"
var best_score = 0 setget bestScore

func _ready():
	loadBest()
	pass
	
func loadBest():
	var file = File.new()
	if not file.file_exists(FILE_PATH):
		return
	file.open(FILE_PATH, File.READ)
	best_score = file.get_var()
	file.close()
	pass
	
func saveBest():
	var file = File.new()
	file.open(FILE_PATH, File.WRITE)
	file.store_var(best_score)
	file.close()
	pass
	
func bestScore(newScore):
	best_score = newScore
	saveBest()
	pass


