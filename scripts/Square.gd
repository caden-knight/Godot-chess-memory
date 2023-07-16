extends ColorRect

var correctly_guessed_tiles : Array = []
var coords : Array = Singleton.coords

# checks which square is clicked and if the player clicked the target square
func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse_position = get_global_mouse_position()
		
		if get_global_rect().has_point(mouse_position):
			var target_square: String = Singleton.target_square
			var target_squares : Array = Singleton.target_squares
			var player_guess: String = $Label.text
			
			# update player guess in the singleton
			Singleton.player_guess = player_guess
			
			# get out of function if player clicks a square they have already guessed
			if correctly_guessed_tiles.has(player_guess):
				return
			
			if player_guess == target_square:
				$Label.visible = true
				Singleton.isCorrect = true
				Singleton.target_squares.erase(player_guess) # get rid of correctly guessed squares
			else:
				Singleton.isCorrect = false
			
			# choose new target square
			Singleton.target_square = Singleton.target_squares.pick_random()





