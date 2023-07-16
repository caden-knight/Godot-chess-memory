extends Node

var coords: Array = [["A", "B", "C", "D", "E", "F", "G", "H"], [1,2,3,4,5,6,7,8]]
var target_squares: Array = []
var target_square: String
var player_guess: String = ""
var isCorrect: bool

func _ready():
	for file in range(7, -1, -1):
		for rank in range(7, -1, -1):
			target_squares.push_back(coords[0][file] + str(coords[1][rank]))
