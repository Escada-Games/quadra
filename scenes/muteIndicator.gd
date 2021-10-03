extends Control
func _ready()->void:
	setupColors()
	var _s1=global.connect("palChanged",self,'setupColors')
	set_process(true)
func setupColors()->void:
	self.modulate=global.aCurrentPal[2]
func _process(_d)->void:
	self.visible = AudioServer.is_bus_mute(AudioServer.get_bus_index('Master'))
	pass
