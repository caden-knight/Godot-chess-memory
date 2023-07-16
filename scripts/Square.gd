extends ColorRect
#
func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse_position = get_global_mouse_position()
		
		if get_global_rect().has_point(mouse_position):
			var player_guess: String = $Label.text
			var target_square = Singleton.target_square
			print(player_guess)
			Singleton.player_guess = player_guess
			

			if player_guess == target_square:
				$Label.visible = true
				# TODO: remove correct squares from the array
				print("Nice!")
			else:
				print("FOOL")
			var coords = Singleton.coords
			Singleton.target_square = coords[0].pick_random() + str(coords[1].pick_random())
			print(Singleton.target_square)






