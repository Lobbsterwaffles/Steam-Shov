extends Marker2D

@export var color := Color.RED
@export var radius := 25

func _draw():
	draw_circle(Vector2.ZERO, radius, color, true, -1, true)

	
