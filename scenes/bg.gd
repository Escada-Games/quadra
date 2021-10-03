extends Node2D
const vMotion:=Vector2(1,1)*10
func _ready()->void:
	setupColors()
	var _s1:=global.connect("palChanged",self,'setupColors')
	self.visible=true
	self.set_physics_process(true)
func setupColors():
	self.modulate = global.aCurrentPal[0].lightened(0.33)
func _physics_process(delta:float)->void:
	self.global_position+=self.vMotion*delta
	if self.global_position.x>=0:self.global_position=Vector2(-4,-4)
