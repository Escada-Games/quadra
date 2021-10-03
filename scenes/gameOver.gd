extends Control
func _ready()->void:
	self.visible=false
	var _s1=global.connect("gameOver",self,'appear')
	set_process(false)
func appear()->void:
	self.visible=true
	set_process(true)
func _process(_d:float)->void:
	if Input.is_action_just_pressed("ui_accept"):
		global.restart()
		self.visible=false
