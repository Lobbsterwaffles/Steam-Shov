extends Area2D

var polygonge

func _ready():
	print("Sugme")
	body_entered.connect(_ae)

func _ae(other):
	print("AE ", other)
	print(other.get_node("%scoopshape"))
	queue_redraw()
	var shape = other.get_node("%scoopshape")
	var gpoly = Transform2D(0, shape.global_position) * shape.polygon
	var clips = Geometry2D.clip_polygons(%poly.polygon, gpoly)
	polygonge = clips[0]
	%poly.set_deferred("polygon", clips[0])
	
func _draw():
	if polygonge == null:
		return
	draw_colored_polygon(polygonge, Color.BLUE)
