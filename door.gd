extends RigidBody2D

var pinjoint : PinJoint2D

func _physics_process(dt):
	if Input.is_key_pressed(KEY_T):
		if pinjoint:
			return
		pinjoint = PinJoint2D.new()
		pinjoint.position = to_local(%hingemarker.global_position)
		pinjoint.node_a = self.get_path()
		pinjoint.node_b = %scoop.get_path()
		self.freeze = false
		add_child(pinjoint)
	
