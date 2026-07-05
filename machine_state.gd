extends Node

signal upgrade_applied(u: Upgrade)

var applied: Dictionary = {}

func apply_upgrade(u: Upgrade) -> void:
	print("Appl ", u.id, " ", applied)
	if has_upgrade(u.id):
		print("cannot reapply")
		return

	applied[u.id] = u
	upgrade_applied.emit(u)

func has_upgrade(id):
	return applied.has(id)

func bind(callback: Callable) -> void:
	for u in applied.values():
		callback.call(u)
	upgrade_applied.connect(callback)
