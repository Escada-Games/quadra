extends Label
var t:=0
func _ready()->void:
	set_process(true)
	setupColors()
	var _s1=global.connect("palChanged",self,'setupColors')
func setupColors()->void:
	self.self_modulate=global.aCurrentPal[2]
func _process(_d)->void:
	if global.bInvulnerable:
		t+=1
		self.modulate.a = 0 if t%2==0 else 1
	else:
		self.modulate.a=1
	var strText=''
	for _a in range(global.iLifes):
		strText+='#'
	self.text=strText
