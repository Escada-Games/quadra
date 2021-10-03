extends Control
var strCurrentPal:='Quadra'
func _ready()->void:
	setupColors()
	self.modulate.a=0
	var _s1=global.connect("palChanged",self,'setupColors')
	set_process(true)
func setupColors()->void:
	self.modulate=global.aCurrentPal[2]
func _process(_d)->void:
	if strCurrentPal!=global.strCurrentPal:
		self.modulate.a=1
		strCurrentPal=global.strCurrentPal
		if 'palette' in strCurrentPal:
			$marginContainer/label.text = strCurrentPal
		else:
			$marginContainer/label.text = 'Current palette:' + strCurrentPal
		$tween.stop_all()
		$tween.interpolate_property(self,'modulate:a',1,0,0.6,Tween.TRANS_QUAD,Tween.EASE_IN,2.0)
		$tween.start()

