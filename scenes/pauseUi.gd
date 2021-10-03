extends Control
func _ready()->void:
	self.visible=false
	set_process(true)
func _process(_d)->void:
	if Input.is_action_just_pressed("ui_pause"):
		get_tree().paused=!get_tree().paused
		self.visible=get_tree().paused
