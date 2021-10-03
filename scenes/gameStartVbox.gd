extends VBoxContainer
func _ready()->void:
	setupColors()
	var _s1=global.connect("palChanged",self,'setupColors')
func setupColors()->void:
	self.modulate=global.aCurrentPal[2]
