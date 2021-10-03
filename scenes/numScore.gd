extends Label
var iLocalScore:=0
func _ready()->void:
	set_process(true)
	setupColors()
	var _s1=global.connect("palChanged",self,'setupColors')
func setupColors()->void:
	self.self_modulate=global.aCurrentPal[2]
func _process(_d:float)->void:
	if iLocalScore!=global.iScore:
		iLocalScore=int(ceil(lerp(iLocalScore,global.iScore,0.1)))
	self.text=str("%010d" % iLocalScore)
