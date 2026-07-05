extends Panel

@export var upgrades: UpgradeTable 

var opt : OptionButton
var selected 

func _ready():
	%cheat_apply.pressed.connect(apply_selected)
	
	opt = %cheat_select_upgrade
	var optid = 0
	for r in upgrades.rows:
		opt.add_item(r.id)
		opt.set_item_metadata(opt.item_count - 1, r)
	print(MachineState)

func apply_selected():
	if opt.selected == -1:
		return
	MachineState.apply_upgrade(opt.get_item_metadata(opt.selected))
	_update_owned()
	
func _update_owned():
	var box = %cheat_upgrade_list
	for ch in box.get_children():
		box.remove_child(ch)
		ch.queue_free()
	for up in MachineState.applied:
		var lbl = Label.new()
		lbl.text = up
		box.add_child(lbl)
		
