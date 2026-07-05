extends Node2D

@export var height :=  120.0
@export var track_color := Color.BLACK
@export var marker_color := Color.YELLOW
@export var track_width := 10
@export var marker_radius := 10
@export var lever_position := 0.0

func set_lever_position(v):
	lever_position = v
	queue_redraw()

func _draw():
	var bot := Vector2(0, 0.5*height)
	var top := Vector2(0, -0.5*height)

	draw_line(bot, top, track_color, track_width, true)
	draw_circle(bot.lerp(top, lever_position), marker_radius, marker_color, -1, true)
	# draw_circle(Vector2.ZERO, 10, Color.YELLOW)
