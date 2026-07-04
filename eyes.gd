extends Node2D

@export var eye_white := Color.WHITE
@export var eye_pupil := Color.BLACK
@export var eye_liner := Color.BLACK

func _process(dt):
	queue_redraw()

func _draw():
	const major := 10.0
	const minor := 5.0

	draw_ellipse(Vector2.ZERO, major, minor, eye_white)
	draw_ellipse(Vector2.ZERO, major, minor, eye_liner, false, 2.0, true)
	var target = to_local(%scoop.global_position).normalized()
	var epnt = ellipse_ray(target,  major, minor)
	const rdot = 3
	var epoff = ellipse_offset(epnt, major, minor, -0.5*rdot)
	draw_circle(epoff, rdot, eye_pupil)

func ellipse_ray(v: Vector2, a: float, b: float) -> Vector2:
	if v == Vector2.ZERO:
		return Vector2.ZERO

	var s := sqrt((v.x * v.x) / (a * a) + (v.y * v.y) / (b * b))
	return v / s

func ellipse_offset(p: Vector2, a: float, b: float, d: float) -> Vector2:
	var n := Vector2(p.x / (a * a), p.y / (b * b)).normalized()
	return p + d * n
