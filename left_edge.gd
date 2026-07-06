extends Polygon2D

func _ready():
	$Timer.timeout.connect(interval)

func interval():
	var xf = %poly.global_transform.affine_inverse() * global_transform
	var pieces = Geometry2D.clip_polygons(%poly.polygon, xf * polygon)
	var mrk = xf * $Marker2D.position
	for p in pieces:
		if Geometry2D.is_point_in_polygon(mrk, p):
			%poly.polygon = p
			%visualdirt.polygon = p
			%poly.queue_redraw()
			%visualdirt.queue_redraw()
			return
		
