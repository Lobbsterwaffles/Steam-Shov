extends Node2D




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func pause():
	get_tree().paused = true
	%PauseMenu.show()
	
func unpause():
	%PauseMenu.hide()
	get_tree().paused = false
	
func restart():
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func help():
	%help_Screen.show()
	
func closehelp():
	%help_Screen.hide()
	
func game_over():
	get_tree().paused = true
	%kill_screen.show()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if %scoop.coal <= 0:
		game_over()
	
	pass


func _on_resume_pressed() -> void:
	pass # Replace with function body.
