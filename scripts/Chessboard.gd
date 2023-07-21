extends Node2D

@onready var squareScene := preload("res://scenes/square.tscn")
@onready var viewport_size := get_viewport_rect().size
@onready var squares := $Squares
@onready var target_square_label := $TargetSquare
@onready var guess_square_label := $GuessSquare
@onready var target_square: String = Singleton.target_squares.pick_random()
@onready var original_screen_width: float = viewport_size.x
@onready var original_screen_height: float = viewport_size.y

var isWhite: bool = true
var squareX: float = 0
var squareY: float = 0
var direction: int = 1
var coords = Singleton.coords

func _ready():
	setup_board(false, viewport_size.y)
	Singleton.target_square = target_square

# update labels when mouse is clicked
func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		target_square_label.text = Singleton.target_square
		guess_square_label.text = Singleton.player_guess
		
		# font color is red if incorrect square is clicked
		# or green if correct square is clicked
		var labelColor: Color = Color(0, 255, 0, 1) if Singleton.isCorrect else Color(255, 0, 0, 1)
		guess_square_label.add_theme_color_override("font_color", labelColor )

# sets up the 8x8 grid and aligns the squares to make a chessboard
func setup_board(show_square_labels: bool, square_size: float) -> void:
	# necessary for the order the squares are instantiated
	coords[0].reverse()
	
	# chooses a random square for player to find
	target_square_label.text = target_square
	
	# allows the board to fill the screen from top to bottom perfectly
	var square_dimensions: Vector2 = Vector2(square_size / 8, square_size / 8)
	var offset := get_viewport_rect().size.x - (square_dimensions.x * 8)
	
	# sets up and labels the chess board
	for file in range(7, -1, -1):
		for rank in range(7, -1, -1):
			var square : ColorRect = squareScene.instantiate()
			var squareLabel := square.get_child(0)

			# setup squares and add to scene
			square.set_size(square_dimensions)
			square.position = Vector2(squareX, squareY)
			square.color = Color(1,1,1,1) if isWhite else Color(0,0,0,1)
			squareLabel.text = coords[0][file] + str(coords[1][rank])
			squareLabel.visible = show_square_labels 
			squares.add_child(square)
			target_square_label.position = Vector2(0,0)

			# space and align the squares
			if rank != 0:
				squareY += square_dimensions.y
				isWhite = !isWhite
			else:
				squareX += square_dimensions.x
				squareY = 0

	# centers the chessboard
	squares.position.x += offset / 2

