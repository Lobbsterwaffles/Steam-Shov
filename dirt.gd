extends Area2D

var cutter
var clock = 0

@export var min_bite := 10.0

var total_area := 0.0
var area_capacity := 10000 # maybe should be derived from actual scoop area?

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

	if %door.carried_area >= area_capacity:
		# print("Fullge")
		return
	
	var xf = %poly.global_transform.affine_inverse() * cutter.global_transform
	var localcut = xf * cutter.polygon
	var isectA := intersect_area(%poly.polygon, localcut)
	if isectA < min_bite:
		return

	%door.carried_area += isectA

	var clips = Geometry2D.clip_polygons(%poly.polygon, localcut)
	if clips.is_empty():
		return
	%poly.set_deferred("polygon", clips[0])
	queue_redraw()

func _draw():
	draw_colored_polygon(%poly.polygon, Color.BLACK)

func signed_area(poly: PackedVector2Array) -> float:
	var a := 0.0
	var n := poly.size()

	for i in n:
		var p := poly[i]
		var q := poly[(i + 1) % n]
		a += p.x * q.y - q.x * p.y

	return 0.5 * a


func intersect_area(a: PackedVector2Array, b: PackedVector2Array) -> float:
	var rings := Geometry2D.intersect_polygons(a, b)

	var total := 0.0
	for r in rings:
		total += signed_area(r)

	return abs(total)
