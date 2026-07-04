extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

@onready var guysprite: AnimatedSprite2D = %guysprite

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_pressed("crowd_in") and Input.is_action_pressed("hoist_up") or 
		Input.is_action_pressed("hoist_up") and Input.is_action_pressed("crowd_out")):
		guysprite.play("bofa")
	elif Input.is_action_pressed("hoist_up"):
			guysprite.play("front")
	elif (Input.is_action_pressed("crowd_in") or Input.is_action_pressed("crowd_out")):
		guysprite.play("back")
	else:
		guysprite.play("neither")
	
		
	
	pass
