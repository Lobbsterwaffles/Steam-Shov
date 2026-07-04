extends Area2D

var cutter
var clock = 0

func _ready():
	body_entered.connect(_enter)
	body_exited.connect(_exit)

func _enter(other):
	var scoop = other.get_node("%scoopshape")
	if not scoop:
		return
	cutter = scoop

func _exit(other):
	var scoop = other.get_node("%scoopshape")
	if not scoop:
		return
	
func _physics_process(dt):
	if not cutter:
		clock = 0
		return
	clock += dt 
	if clock < 0.2:
		return
	clock = 0
	var xf = %poly.global_transform.affine_inverse() * cutter.global_transform
	var clips = Geometry2D.clip_polygons(%poly.polygon, xf * cutter.polygon)
	if clips.is_empty():
		return
	%poly.set_deferred("polygon", clips[0])
	queue_redraw()

func _draw():
	draw_colored_polygon(%poly.polygon, Color.BLACK)
