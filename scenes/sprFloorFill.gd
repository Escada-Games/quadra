extends Sprite
func _ready():
	setupColors()
	var _s1=global.connect("palChanged",self,'setupColors')
func setupColors():
	self.modulate=global.aCurrentPal[3]
