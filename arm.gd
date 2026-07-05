extends RigidBody2D

@onready var lbl_proto : Label = %arm_dmg_proto

@export var hit_v_threshold := 5
@export var lifetime := 1.25

var move_detected := false

func  _process(dt):
	var vlensq = self.linear_velocity.length_squared()
	if vlensq > hit_v_threshold:
		if not move_detected:
			damage_number(-sqrt(vlensq), global_position)
		move_detected = true
	else:
		move_detected = false

		
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
	var fini := n.position + Vector2(0, -150)
	(t
		.tween_property(n, "position", fini, lifetime)
		.set_trans(Tween.TRANS_QUAD)
		.set_ease(Tween.EASE_OUT))
	t.tween_property(n, "modulate:a", 0.125, lifetime)
	t.finished.connect(n.queue_free)
