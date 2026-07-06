extends Marker2D

@onready var edge = %edge_of_the_screen.global_position

func _process(dt):
	if self.global_position.x < edge.x:
		print("you won")
		get_tree().paused = true
		%victory_screen.show()
