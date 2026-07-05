extends GridContainer

var upgrade_rows: Array[Upgrade] = []

var scn_item = preload("res://shop_item.tscn")
var family_order = []
var my_items = [] # parallel to family_order; each entry is {item: Node, row: Upgrade}

func init_upgrade_table():
	upgrade_rows = UpgradeTable.build_rows()

func _ready():
	init_upgrade_table()
	for r in upgrade_rows:
		if not family_order.has(r.family):
			family_order.append(r.family)
	build_items()
	populate()

func build_items():
	var me = self
	for i in family_order.size():
		var u = scn_item.instantiate()
		add_child(u)
		my_items.append({"item": u, "row": null})
		u.get_node("%button").pressed.connect(
			func():
				var row = my_items[i].row
				if row == null:
					return
				MachineState.apply_upgrade(row)
				me.populate()
		)

func populate():
	print("Repopulatiung", self)

	var f2u = {}
	for r in upgrade_rows:
		f2u.get_or_add(r.family, []).append(r)
	var f2lowesttier = {}
	for f in f2u:
		for u in f2u[f]:
			if MachineState.has_upgrade(u.id):
				print("You already have ", u.id)
				continue
			if not f2lowesttier.has(f) or u.tier < f2lowesttier[f].tier:
				f2lowesttier[f] = u

	for i in family_order.size():
		var f = family_order[i]
		var r = f2lowesttier.get(f)
		var u = my_items[i].item
		my_items[i].row = r
		if r == null:
			u.get_node("%button").text = ""
			u.get_node("cost_readout/%money").amount = 9999
		else:
			u.get_node("%button").text = r.id
			u.get_node("cost_readout/%money").amount = r.cost
