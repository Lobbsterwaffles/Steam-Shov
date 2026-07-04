extends RigidBody2D

@export var sheave: Node2D
@export var myradius := 20.0
@export var side := -1.0

@export var engine_speed := 76.0
@export var clutch_force := 300000.0
@export var brake_force := 500000.0

@export var clutch_press_curve : Curve
@export var brake_press_curve : Curve
@export var clutch_release_curve : Curve
@export var brake_release_curve : Curve

const CLUTCH_PRESS_T := 0.5
const CLUTCH_RELEASE_T := 0.5
const BRAKE_PRESS_T := 0.5
const BRAKE_RELEASE_T := 0.5

const BRAKE_SLOP := 0.25

var forcedir := Vector2.ZERO
var load_local := Vector2.ZERO
var tangent_local := Vector2.ZERO

var length := 0.0
var lastlength := 0.0
var v_along := 0.0

var clutch_phase := 0.0
var brake_phase := 0.0

var clutch_amount := 0.0
var brake_amount := 0.0
var brake_lock_amount := 0.0

var brake_anchor := 0.0
var brake_locked := false

var j_clutch := 0.0
var j_brake := 0.0
var j_total := 0.0

func _ready() -> void:
	if sheave != null:
		_update_geometry(global_position)
		lastlength = length
		brake_anchor = length
	queue_redraw()

	# body_entered.connect(_on_body_entered)


func _tangent(pa: Vector2, s: float) -> Vector2:
	var alpha := acos(myradius / pa.length())
	return myradius * Vector2.from_angle(pa.angle() + s * alpha)

func _update_geometry(world_pos: Vector2) -> void:
	load_local = sheave.to_local(world_pos)
	tangent_local = _tangent(load_local, side)

	lastlength = length
	length = load_local.distance_to(tangent_local)

	var tangent_world := sheave.to_global(tangent_local)
	forcedir = (tangent_world - world_pos).normalized()

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var dt = state.step

	_update_geometry(state.transform.origin)
	v_along = state.linear_velocity.dot(forcedir)

	# Lock is a hack to prevent solver jitter from pushing us slowly downwards
	if brake_amount > 0.8 and absf(length - lastlength) < 0.4:
		if brake_lock_amount <= 0.0:
			brake_anchor = length
		brake_lock_amount = 1

	if Input.is_key_pressed(KEY_Q):
		clutch_phase = move_toward(clutch_phase, 1.0, dt / CLUTCH_PRESS_T)
		clutch_amount = clutch_press_curve.sample_baked(clutch_phase)
	else:
		clutch_phase = move_toward(clutch_phase, 0.0, dt / CLUTCH_RELEASE_T)
		clutch_amount = clutch_release_curve.sample_baked(1.0 - clutch_phase)

	if Input.is_key_pressed(KEY_SPACE):
		brake_phase = move_toward(brake_phase, 1.0, dt / BRAKE_PRESS_T)
		brake_amount = brake_press_curve.sample_baked(brake_phase)
	else:
		brake_phase = move_toward(brake_phase, 0.0, dt / BRAKE_RELEASE_T)
		brake_amount = brake_release_curve.sample_baked(1.0 - brake_phase)
		brake_lock_amount = 0.0
		
	j_clutch = 0.0
	j_brake = 0.0
	j_total = 0.0
	
	if clutch_amount > 0.0:
		var v_target := engine_speed * clutch_amount
		j_clutch = mass * (v_target - v_along)
		j_clutch = clampf(j_clutch, 0.0, clutch_force * clutch_amount * dt)

	if brake_amount > 0.0:
		var brake_error := length - brake_anchor
		var v_hold := 0.0

		if brake_error > BRAKE_SLOP:
			v_hold = brake_lock_amount * (brake_error - BRAKE_SLOP) / dt

		j_brake = mass * (v_hold - v_along)
		j_brake = clampf(j_brake, 0.0, brake_force * brake_amount * dt)

	j_total = j_clutch + j_brake

	state.apply_force(Vector2(0, 100), Vector2(0, 40))

	if j_total > 0.0:
		state.apply_central_impulse(j_total * forcedir)

	queue_redraw()

func _bar(label: String, x: float, value: float, color: Color) -> void:
	var font := ThemeDB.fallback_font
	var h := clampf(value, -1.0, 1.0) * 32
	var base := Vector2(x, 0.0)

	draw_line(base + Vector2(-3.0, 0.0), base + Vector2(3.0, 0.0), Color.DIM_GRAY, 1.0)
	draw_line(base, base + Vector2(0.0, -h), color, 3.0)
	var label_size := font.get_string_size(label)
	draw_string(font, base + Vector2(-label_size.x / 2, 13.0), label)

func _draw() -> void:
	var sl = to_local(sheave.global_position)
	var qq = sheave.position + Vector2(0,0) # tangent_local
	draw_circle(sl, myradius, Color.BLACK, false, 2)
	draw_line(Vector2.ZERO, to_local(sheave.to_global(tangent_local)), Color.BLACK, 2)
	# draw_line(Vector2.ZERO, to_local(sheave.global_position), Color.BLACK, 2)

	draw_set_transform(to_local(sheave.global_position), -global_rotation, Vector2.ONE)

	draw_line(Vector2.ZERO, forcedir * (j_total * 0.01), Color.RED, 3.0)
	draw_line(Vector2.ZERO, forcedir * (v_along * 0.3), Color.GREEN, 2.0)
	var x := 52.0
	_bar("C", x, clutch_amount, Color.RED)
	x += 10.0
	_bar("B", x, brake_amount, Color.GREEN)
	x += 10.0
	_bar("L", x, brake_lock_amount, Color.CYAN)
	x += 10.0
	_bar("c", x, j_clutch * 1e-3, Color.YELLOW)
	x += 10.0
	_bar("b", x, j_brake * 1e-3, Color.ORANGE)
	x += 10.0
	
	
