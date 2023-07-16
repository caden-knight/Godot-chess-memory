extends Node2D

@onready var squareScene := preload("res://scenes/square.tscn")
@onready var viewport_size := get_viewport_rect().size
@onready var squares := $Squares
@onready var target_square_label := $TargetSquare


var isWhite: bool = true
var squareX: float = 0.0
var squareY: float = 0.0
var direction: int = 1
var coords = Singleton.coords
var target_square: String = coords[0].pick_random() + str(coords[1].pick_random())

func _ready():
	Singleton.target_square = target_square
	print(Singleton.target_square)
	setup_board()
	
func setup_board() -> void:
	# necessary for the order the squares are instantiated
	coords[0].reverse()
	
	# chooses a random square for player to find
	target_square_label.text = target_square
	
	# allows the board to fill the screen from top to bottom perfectly
	var square_size: Vector2 = Vector2(viewport_size.y / 8, viewport_size.y / 8,)
	var offset := viewport_size.x - (square_size.x * 8)
	
	# sets up and labels the chess board
	for file in range(7, -1, -1):
		for rank in range(7, -1, -1):
			var square : ColorRect = squareScene.instantiate()
			var squareLabel := square.get_child(0)

			# setup squares and add to scene
			square.set_size(square_size)
			square.position = Vector2(squareX, squareY)
			square.color = Color(1,1,1,1) if isWhite else Color(0,0,0,1)
			squareLabel.text = coords[0][file] + str(coords[1][rank])
			squareLabel.visible = false 
			squares.add_child(square)

			# space and align the squares
			if rank != 0:
				squareY += square_size.y
				isWhite = !isWhite
			else:
				squareX += square_size.x
				squareY = 0

	# centers the chessboard
	squares.position.x += offset / 2

