extends Label

func _ready():
	setupColors()
	var _s1=global.connect("palChanged",self,'setupColors')
func setupColors():
	self.self_modulate=global.aCurrentPal[2]
