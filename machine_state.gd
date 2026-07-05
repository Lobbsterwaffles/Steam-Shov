extends Node

signal upgrade_applied(u: Upgrade)

var applied: Dictionary = {}

func apply_upgrade(u: Upgrade) -> void:
	if applied.has(u.id):
		return
	applied[u.id] = u
	upgrade_applied.emit(u)

func bind(callback: Callable) -> void:
	for u in applied.values():
		callback.call(u)
	upgrade_applied.connect(callback)
