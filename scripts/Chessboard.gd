extends Node2D

var coords = [["A", "B", "C", "D", "E", "F", "G", "H"], [1,2,3,4,5,6,7,8]]
var isWhite: bool = true
var squareX: int = 0
var squareY: int = 0
var direction: int = 1

@onready var squareScene := preload("res://scenes/square.tscn")
@onready var viewport_size := get_viewport_rect().size


func _ready():
	game_setup()
	
func game_setup() -> void:
	coords[0].reverse()
	var square_size = viewport_size.y / 8
	
	for rank in range(7, -1, -1):
		for file in range(7, -1, -1):
			var square : ColorRect = squareScene.instantiate()
			var squareLabel = square.get_child(0)
			
			
			
			print(get_viewport_rect().size.x)
			square.set_size(Vector2(square_size, square_size))
			square.position = Vector2(squareX, squareY)
			square.color = Color(1,1,1,1) if isWhite else Color(0,0,0,1)
			squareLabel.text = coords[0][rank] + str(coords[1][file])
			add_child(square)
			
			
			if file != 0:
				squareY += square.get_size().y
				isWhite = !isWhite
			else:
				squareX += square.get_size().x
				squareY = 0
				
#			print("coordinate: " + coords[0][rank] + str(coords[1][file]))
			
			
			
			print(file)
