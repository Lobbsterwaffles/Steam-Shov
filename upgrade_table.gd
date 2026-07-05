class_name UpgradeTable

static func build_rows() -> Array[Upgrade]:
	var rows: Array[Upgrade] = []
	var u: Upgrade

	u = Upgrade.new()
	u.id = "Faster Hoist"
	u.family = "Hoist"
	u.cost = 25.0
	u.hoist_engine_speed = 105.0
	u.hoist_clutch_force = 1.0
	u.hoist_brake_force = 50000.0
	rows.append(u)

	u = Upgrade.new()
	u.id = "Bigger Bucket"
	u.family = "Bucket"
	u.cost = 50.0
	u.bucket_capacity = 5000.0
	rows.append(u)

	u = Upgrade.new()
	u.id = "Efficiency"
	u.family = "Efficiency"
	u.cost = 35.0
	u.efficiency = 0.1
	rows.append(u)

	return rows
