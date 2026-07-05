extends RigidBody2D

@export var drive_force := 9000.0

@export var gear_speed_coef := 0.04

var forcedir : Vector2
var pinjoint : PinJoint2D
var clutch_phase := 0.0
const CLUTCH_PRESS_T := 0.23
const CLUTCH_RELEASE_T := 0.1

func _ready() -> void:
	MachineState.bind(apply_upgrade)
	_update_geometry()
	queue_redraw()

func apply_upgrade(u: Upgrade) -> void:
	drive_force += u.crowd_drive_force

func _update_geometry() -> void:
	var j := %j_crowd_sliderblock as Node2D
	var slider := %sliderblock as Node2D

func pin():
	if pinjoint:
		return
	pinjoint = PinJoint2D.new()
	pinjoint.position = to_local(%sliderblock.global_position)
	pinjoint.node_a = self.get_path()
	pinjoint.node_b = %arm.get_path()
	add_child(pinjoint)

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var dt := state.step
	_update_geometry()
	queue_redraw()
	if pinjoint:
		forcedir = Vector2.ZERO
	else:
		forcedir = (%j_crowd_sliderblock.global_position - %sliderblock.global_position).normalized()

	if Input.is_action_pressed("crowd_in"):
		if clutch_phase > 0:
			clutch_phase = 0
		clutch_phase = move_toward(clutch_phase, -1, dt / CLUTCH_PRESS_T)
	elif Input.is_action_pressed("crowd_out"):
		if clutch_phase < 0:
			clutch_phase = 0
		clutch_phase = move_toward(clutch_phase, 1, dt / CLUTCH_PRESS_T)
	else:
		clutch_phase = move_toward(clutch_phase, 0, dt / CLUTCH_RELEASE_T)
		
	%crowd_gear.angular_velocity = forcedir.dot(linear_velocity) * gear_speed_coef
	forcedir *= drive_force * clutch_phase

	var hlpos := 0.5*(1+clutch_phase)
	%crowd_lever.set_lever_position(hlpos)

	state.apply_central_force(forcedir)


func _input(ev):
	if Input.is_action_pressed("crowd_brake"):
		pin()
	else:
		if pinjoint:
			pinjoint.queue_free()

func _draw():
	draw_circle(Vector2.ZERO, 10, Color.RED)
	draw_set_transform_matrix(get_global_transform().affine_inverse())
	var g := global_position

	if forcedir.length() > 0.1:
		draw_line(g,  g + 0.004*forcedir, Color.GREEN, 8.0)


		
	
