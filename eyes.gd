extends Node2D

@export var eye_white := Color.WHITE
@export var eye_pupil := Color.BLACK
@export var eye_liner := Color.BLACK

@export var ellipse_major_radius := 10.0
@export var ellipse_minor_radius := 5.0
@export var pupil_major_radius := 3.0
@export var pupil_minor_radius := 3.0
@export var pupil_edge_offset_frac := 0.5 

func _process(dt):
	queue_redraw()

func _draw():
	var major = ellipse_major_radius
	var minor = ellipse_minor_radius

	draw_ellipse(Vector2.ZERO, major, minor, eye_white)
	draw_ellipse(Vector2.ZERO, major, minor, eye_liner, false, 2.0, true)
	var target = to_local(%scoop.global_position).normalized()
	var epnt = ellipse_ray(target,  major, minor)
	var pr = pupil_major_radius 
	var epoff = ellipse_offset(epnt, major, minor, -1 * pr * pupil_edge_offset_frac)
	draw_ellipse(epoff, pupil_major_radius, pupil_minor_radius, eye_pupil, true, -1, true)

	# draw_circle(epoff, pupil_radius, eye_pupil, true, -1, true)

func ellipse_ray(v: Vector2, a: float, b: float) -> Vector2:
	if v == Vector2.ZERO:
		return Vector2.ZERO

	var s := sqrt((v.x * v.x) / (a * a) + (v.y * v.y) / (b * b))
	return v / s

func ellipse_offset(p: Vector2, a: float, b: float, d: float) -> Vector2:
	var n := Vector2(p.x / (a * a), p.y / (b * b)).normalized()
	return p + d * n
