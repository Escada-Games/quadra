extends PanelContainer

func _ready()->void:
	setupColors()
	var _s1=global.connect("palChanged",self,'setupColors')
func setupColors()->void:
	self.self_modulate=global.aCurrentPal[0]
