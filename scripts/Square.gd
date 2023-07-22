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

			# get out of function if player clicks a square they have already guessed
			if correctly_guessed_tiles.has(player_guess):
				Singleton.isCorrect = false
#				Singleton.player_guess = player_guess
#				$Label.visible = true if Singleton.game_mode == 0 else false
				return

			# evaluate the player guess against the target square
			if player_guess == target_square:
				Singleton.player_guess = player_guess # update player guess in the singleton
				$Label.visible = true if Singleton.game_mode == 0 else false # see coordinate label on the chessboard itself
				Singleton.isCorrect = true # sets text color to green
				correctly_guessed_tiles.append(player_guess) # keep track of squares already clicked on
				Singleton.target_squares.erase(player_guess) # get rid of correctly guessed squares
				Singleton.correct_count+=1 # add one to correct count
			else:
				Singleton.isCorrect = false # sets text color to red
				Singleton.player_guess = player_guess # update player guess in the singleton

			# if target_square array is empty get out of function
			if Singleton.target_squares.size() <= 0:
				Singleton.target_square = ""
				return

			# choose new target square
			Singleton.target_square = Singleton.target_squares.pick_random()
