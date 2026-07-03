extends RigidBody2D
func _process(dt):
	queue_redraw()

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var dt := state.step

	var j =  %j_crowd_sliderblock as Node2D
	var toj = to_local(j.to_global(Vector2(0, j.length)))

	var k = 100.0
	if Input.is_key_pressed(KEY_A):
		state.apply_central_impulse(+1 * k *  mass * toj * dt)
	if Input.is_key_pressed(KEY_S):
		state.apply_central_impulse(-1 * k *  mass * toj * dt)

func _draw():
	var font := ThemeDB.fallback_font
	draw_string(font, Vector2.ZERO, "lmao")
	var vv : Vector2 = to_local(%j_crowd_sliderblock.global_position)
	draw_line(Vector2.ZERO, vv, Color.BLACK, 3)
	var j =  %j_crowd_sliderblock as Node2D
	draw_line(Vector2.ZERO, to_local(j.to_global(Vector2(0, j.length))), Color.BLUE, 9)

	
	
