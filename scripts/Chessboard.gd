extends Node2D

var coords = [["A", "B", "C", "D", "E", "F", "G", "H"], [1,2,3,4,5,6,7,8]]
var isWhite: bool = true
var squareX: float = 0.0
var squareY: float = 0.0
var direction: int = 1

@onready var squareScene := preload("res://scenes/square.tscn")
@onready var viewport_size := get_viewport_rect().size
@onready var squares := $Squares


func _ready():
	game_setup()
	
func game_setup() -> void:
	# necessary for the order the squares are instantiated
	coords[0].reverse()
	
	# allows the board to fill the screen from top to bottom perfectly
	var square_size: Vector2 = Vector2(viewport_size.y / 8, viewport_size.y / 8,)
	var offset = viewport_size.x - (square_size.x * 8)
	
	# sets up and labels the chess board
	for rank in range(7, -1, -1):
		for file in range(7, -1, -1):
			var square : ColorRect = squareScene.instantiate()
			var squareLabel = square.get_child(0)
			
			# setup squares and add to scene
			square.set_size(square_size)
			square.position = Vector2(squareX, squareY)
			square.color = Color(1,1,1,1) if isWhite else Color(0,0,0,1)
			squareLabel.text = coords[0][rank] + str(coords[1][file])
			squares.add_child(square)
			
			
			if file != 0:
				squareY += square.get_size().y
				isWhite = !isWhite
			else:
				squareX += square.get_size().x
				squareY = 0
	squares.position.x += offset / 2
