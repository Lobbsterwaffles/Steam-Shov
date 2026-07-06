extends Area2D

func _ready():
	body_entered.connect(_enter)

func _enter(other):
	other.queue_free()
