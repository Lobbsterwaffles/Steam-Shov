extends RigidBody2D

@onready var lbl_proto : Label = %arm_dmg_proto

@export var hit_v_threshold := 5
@export var lifetime := 1.25
@export var dmg_number_translate := Vector2(0, -150)

@onready var thescoop = %scoop

var move_detected := false

func  _process(dt):
	var vlensq = self.linear_velocity.length_squared()
	if vlensq > hit_v_threshold:
		if not move_detected:
			if arm_hitting_us():
				var dmg = sqrt(vlensq)
				%money.add(-dmg)
				damage_number(-dmg, global_position)
		move_detected = true
	else:
		move_detected = false

func arm_hitting_us():
	for body in get_colliding_bodies():
		if body == thescoop:
			return true
	return false
		
func damage_number(amount: int, pos: Vector2) -> void:
	# var n := Label.new()
	var n := lbl_proto.duplicate() as Label
	n.visible = true
	n.text = str(amount)
	n.z_index = 999
	get_parent().add_child(n)
	n.global_position = pos

	var t := create_tween()
	t.set_parallel(true)
	(t
		.tween_property(n, "position", n.position + dmg_number_translate, lifetime)
		.set_trans(Tween.TRANS_QUAD)
		.set_ease(Tween.EASE_OUT))
	t.tween_property(n, "modulate:a", 0.125, lifetime)
	t.finished.connect(n.queue_free)
