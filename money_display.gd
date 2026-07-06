extends Marker2D

@export var digit_spacing := 24.0

var amount := 0:
	set(value):
		amount = value
		queue_redraw()

func _draw():
	var font := ThemeDB.fallback_font
	var size := ThemeDB.fallback_font_size
	var onespos := Vector2(-5, 0.5*size)
	var s = "%04d" % [amount]

	for i in range(len(s)):
		draw_string(font, onespos + Vector2(-digit_spacing * i, 0), s[3 - i], HORIZONTAL_ALIGNMENT_CENTER, -1, size, Color.BLACK)

func add(x: int):
	amount = maxf(0, x + amount)
	queue_redraw()

func try_pay_cost(x: int):
	if amount < x:
		return false
	amount -= x
	queue_redraw()
	return true
	
