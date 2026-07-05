extends Button

@export var coalcost := 25.0
@export var coalamount := 50.0

func _ready():
	pressed.connect(buycoal)

func buycoal():
	var space : float = %scoop.coal_capacity - %scoop.coal
	if space <= 0.0:
		_flash_label(%label_coal_full)
		return

	var amount := minf(coalamount, space)
	var cost := coalcost * (amount / coalamount)

	if not %money.try_pay_cost(cost):
		_flash_label(%label_coal_nomoney)
		return
	%scoop.coal += amount

func _flash_label(label: Control) -> void:
	label.visible = true
	await get_tree().create_timer(0.75).timeout
	label.visible = false
