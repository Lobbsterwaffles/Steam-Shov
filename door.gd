extends RigidBody2D

var pinjoint : PinJoint2D

var carried_area := 0.0
var area_capacity := 10000 # maybe should be derived from actual scoop area?

var dumping := false


func _physics_process(dt):
	if Input.is_key_pressed(KEY_T):
		if pinjoint:
			return
		# add_child(polybody(random_poly(10, 10, 20, 0.1)))
		pinjoint = PinJoint2D.new()
		pinjoint.position = to_local(%hingemarker.global_position)
		pinjoint.node_a = self.get_path()
		pinjoint.node_b = %scoop.get_path()
		self.freeze = false
		add_child(pinjoint)

	# print("Carry ", carried_area)
	if Input.is_key_pressed(KEY_B):
		dumping = true
	
	if dumping and carried_area > 0.0:
		carried_area -= dirtbucket(2)
	

	if carried_area < 0:
		dumping = false
		carried_area = 0

	update_bucket_gauge()
		
func random_poly(n: int, r1: float, r2: float, jitter: float = 0.0) -> PackedVector2Array:
	var points := PackedVector2Array()
	var angle_step := TAU / n
	for i in n:
		var angle := i * angle_step + randf_range(-jitter, jitter) * angle_step
		var radius := randf_range(r1, r2)
		points.append(Vector2(cos(angle), sin(angle)) * radius)
	return points

func polybody(points: PackedVector2Array) -> RigidBody2D:
	var body := RigidBody2D.new()
	body.collision_layer = (1 << 9)
	body.collision_mask = (1 << 9)

	var collision := CollisionPolygon2D.new()
	collision.polygon = points
	body.add_child(collision)

	return body

func add_dirt(area):
	carried_area += area
	# %bucket_gauge.value = 100.0 * (carried_area / area_capacity)
	update_bucket_gauge()

func update_bucket_gauge():
	%bucket_gauge.value = move_toward(%bucket_gauge.value, 100.0 * (carried_area / area_capacity), 2)

func is_full():
	return carried_area >= area_capacity
	
func power_law_size(smin: float, smax: float, power: float = 2.0) -> float:
	var u := randf()
	var a := 1.0 - power
	var lo := pow(smin, a)
	var hi := pow(smax, a)
	return pow(lo + u * (hi - lo), 1.0 / a)

func cluster_points(count: int, half: Vector2) -> PackedVector2Array:
	var points := PackedVector2Array()
	for i in count:
		points.append(Vector2(randf_range(-half.x, half.x), randf_range(-half.y, half.y)))
	return points

func dirtbucket(n):
	var parent := %dirtparent as Node2D
	var approx_area := 0.0
	for center in cluster_points(n, Vector2(28, 28)):
		var r2 := power_law_size(10, 20, 2.5)
		var r1 := r2 * randf_range(0.4, 0.8)
		var rm := 0.5 * (r1 + r2)
		var body := polybody(random_poly(12, r1, r2))
		var area := 0.5 * PI * rm * rm
		approx_area += area
		body.mass = area
		print("A ", area)
		body.position = parent.to_local(%scoop.to_global(center))
		parent.add_child(body)
	return approx_area
	
