extends Area2D

@export var money_per_dirt := 1

var despawning := 1.0
var despawn_max := 1.0
var pending_despawn := []


func _ready():
	body_entered.connect(despawn)
	
	
func despawn(body):
	pending_despawn.append(body)
	


	
func _process(delta: float) -> void:
	despawning += delta * 10
	if despawning >= despawn_max:
		despawning  = despawn_max
	while despawning > 0 and not pending_despawn.is_empty():
		var to_destroy = pending_despawn.pop_back()
		if is_instance_valid(to_destroy) == true:			
			%money.add(money_per_dirt)
			to_destroy.queue_free()
			despawning -= 1
		
	return
		
	
	
