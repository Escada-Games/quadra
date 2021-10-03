extends Label
func _ready()->void:
	set_process(true)
	setupColors()
	var _s1=global.connect("palChanged",self,'setupColors')
func setupColors()->void:self.self_modulate=global.aCurrentPal[2]
func _process(_d:float)->void:self.text=str(global.iUnlocks)+' of 10'
