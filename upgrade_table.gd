class_name UpgradeTable



static func build_rows() -> Array[Upgrade]:
	var rows: Array[Upgrade] = []
	var u: Upgrade
	var hoist_up_cost := 50.0
	var bucket_up_cost := 100.0
	var efficiency_up_cost := 100.0
	var suckdown_up_cost := 50.0
	

	u = Upgrade.new()
	u.id = "Hoist II"
	u.family = "Hoist"
	u.tier = 1
	u.cost = hoist_up_cost
	u.hoist_engine_speed = 30.0
	u.hoist_clutch_force = 1.0
	u.hoist_brake_force = 50000.0
	rows.append(u)

	u = Upgrade.new()
	u.id = "Hoist III"
	u.family = "Hoist"
	u.tier = 2
	u.cost = hoist_up_cost * u.tier
	u.hoist_engine_speed = 30.0
	u.hoist_clutch_force = 1.0
	u.hoist_brake_force = 50000.0
	rows.append(u)

	u = Upgrade.new()
	u.id = "Hoist IV"
	u.family = "Hoist"
	u.tier = 3
	u.cost = hoist_up_cost * u.tier
	u.hoist_engine_speed = 30.0
	u.hoist_clutch_force = 1.0
	u.hoist_brake_force = 50000.0
	rows.append(u)

	u = Upgrade.new()
	u.id = "Hoist V"
	u.family = "Hoist"
	u.tier = 5
	u.cost = hoist_up_cost * u.tier
	u.hoist_engine_speed = 30.0
	u.hoist_clutch_force = 1.0
	u.hoist_brake_force = 50000.0
	rows.append(u)


	u = Upgrade.new()
	u.id = "Bigger Bucket II"
	u.family = "Bucket"
	u.tier = 2
	u.cost = bucket_up_cost * u.tier
	u.bucket_capacity = 3000.0
	rows.append(u)

	u = Upgrade.new()
	u.id = "Bigger Bucket III"
	u.family = "Bucket"
	u.tier = 3
	u.cost = bucket_up_cost * u.tier
	u.bucket_capacity = 3000.0
	rows.append(u)

	u = Upgrade.new()
	u.id = "Bigger Bucket IV"
	u.family = "Bucket"
	u.tier = 4
	u.cost = bucket_up_cost * u.tier
	u.bucket_capacity = 3000.0
	rows.append(u)

	u = Upgrade.new()
	u.id = "Bigger Bucket V"
	u.family = "Bucket"
	u.tier = 5
	u.cost = bucket_up_cost * u.tier
	u.bucket_capacity = 3000.0
	rows.append(u)

	u = Upgrade.new()
	u.id = "Coal Efficiency II"
	u.family = "Efficiency"
	u.tier = 2
	u.cost = efficiency_up_cost * u.tier
	u.efficiency = 0.1
	rows.append(u)
	
	u = Upgrade.new()
	u.id = "Coal Efficiency III"
	u.family = "Efficiency"
	u.tier = 3
	u.cost = efficiency_up_cost * u.tier
	u.efficiency = 0.1
	rows.append(u)
	
	u = Upgrade.new()
	u.id = "Coal Efficiency IV"
	u.family = "Efficiency"
	u.tier = 4
	u.cost = efficiency_up_cost * u.tier
	u.efficiency = 0.1
	rows.append(u)
	
	u = Upgrade.new()
	u.id = "Coal Efficiency V"
	u.family = "Efficiency"
	u.tier = 5
	u.cost = efficiency_up_cost * u.tier
	u.efficiency = 0.1
	rows.append(u)
	
	u = Upgrade.new()
	u.id = "Disposal Speed II"
	u.family = "Cart"
	u.tier = 2
	u.cost = suckdown_up_cost * u.tier
	u.suckdown = 5.0
	rows.append(u)

	u = Upgrade.new()
	u.id = "Disposal Speed III"
	u.family = "Cart"
	u.tier = 3
	u.cost = suckdown_up_cost * u.tier
	u.suckdown = 5.0
	rows.append(u)

	u = Upgrade.new()
	u.id = "Disposal Speed IV"
	u.family = "Cart"
	u.tier = 4
	u.cost = suckdown_up_cost * u.tier
	u.suckdown = 5.0
	rows.append(u)

	u = Upgrade.new()
	u.id = "Disposal Speed V"
	u.family = "Cart"
	u.tier = 5
	u.cost = suckdown_up_cost * u.tier
	u.suckdown = 5.0
	rows.append(u)

	return rows
