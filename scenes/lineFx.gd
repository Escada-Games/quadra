extends Node2D
var bLineScore=true
func _ready()->void:
	randomize()
	self.modulate=global.aCurrentPal[0] if bLineScore else global.aCurrentPal[4]
	self.rotation+=deg2rad(rand_range(-5,5))
	$tween.interpolate_property(self,'scale',Vector2(1,0),Vector2(1,3),0.5,Tween.TRANS_BACK,Tween.EASE_OUT)
	$tween.interpolate_property(self,'modulate:a',1,0,0.3,Tween.TRANS_QUAD,Tween.EASE_IN,0.1)
	$tween.start()
