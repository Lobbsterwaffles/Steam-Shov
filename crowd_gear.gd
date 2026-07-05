extends Node2D

@export var radius := 20
@export var color := Color.BLACK
@export var width := 2
@export var angular_velocity := 0.0 

func _process(dt):
	rotation += angular_velocity * dt
	
