extends RigidBody2D

var bIsActive:=true
var fAngularSpeed:=1.33*PI#PI
var fFallSpeed:float=global.fFallSpeed
var fMoveSpeed:=0
var fMaxMoveSpeed:=88#75
var fGravityMultiplier:=0.0
var fMaxGravityMultiplier:=3.5
var bDisplayOnly:=false
var twn:Tween
var t:=0
var sfxFixed:=preload("res://scenes/sfxPieceFixed.tscn")

func _ready()->void:
	self.set_collision_layer_bit(2,true)
	self.set_collision_mask_bit(2,true)
	self.z_index=5
	setupColors()
#	if global.iScore>200:
#		self.rotation=deg2rad(rand_range(-1,1)*10*clamp(global.iScore/200,1,3))
		
	self.physics_material_override=load("res://scenes/tetris/tetriminoMaterial.tres")
	self.mode = RigidBody2D.MODE_KINEMATIC
	
	twn = Tween.new()
	self.add_child(twn)
	var _s1=global.connect("palChanged",self,'setupColors')
	set_physics_process(!bDisplayOnly)
	
	
func setupColors():
	if !bDisplayOnly:
		if (randf()-0.5)<0:self.modulate=global.aCurrentPal[4].darkened(rand_range(0.0,0.2))
		else:self.modulate=global.aCurrentPal[4].lightened(rand_range(0.0,0.5))
	else:
		self.modulate=global.aCurrentPal[4]
	
func remove():
	if bIsActive:
		get_parent().bHasActiveTetrimino=false
	self.queue_free()
	pass

func _physics_process(delta)->void:
	if self.get_children().size()<=1:self.remove()
	if self.mode == RigidBody2D.MODE_KINEMATIC:
		t+=1
		if t%2==0:
			for n in get_children():
				if not (n is Tween):
					n.updateLine()
		
		if Input.is_action_pressed('ui_spin_cc'):self.rotation-=delta*fAngularSpeed
		elif Input.is_action_pressed('ui_spin_cw'):self.rotation+=delta*fAngularSpeed
		
		var fHorizontalMotion = -1 if Input.is_action_pressed("ui_left") else 1 if Input.is_action_pressed("ui_right") else 0
		if fHorizontalMotion==0:self.fMoveSpeed=0
		self.fMoveSpeed=lerp(self.fMoveSpeed,fHorizontalMotion*fMaxMoveSpeed,0.25)
		
		var fVerticalMotion = 1 if Input.is_action_pressed("ui_down") else 0
		self.fGravityMultiplier=lerp(self.fGravityMultiplier,fVerticalMotion*fMaxGravityMultiplier,0.1)
		
		self.translate(Vector2(fMoveSpeed*delta,fFallSpeed*delta*(1+fGravityMultiplier)))

func bodyEntered(_b)->void:
	if self.mode == RigidBody2D.MODE_KINEMATIC:
		if self.global_position.y<=0:
			print('game over')
			global.emit_signal("gameOver")
		else:
#			global.emit_signal('newPiece')
			global.add_child(sfxFixed.instance())
			self.linear_velocity=Vector2()
			self.inertia=0
			#set_mode(RigidBody2D.MODE_RIGID)
			call_deferred('set_mode',RigidBody2D.MODE_RIGID)
			#set_deferred('set_mode',RigidBody2D.MODE_RIGID)
			get_parent().bHasActiveTetrimino=false
			self.bIsActive=false
			set_physics_process(false)
			for n in get_children():
				if not (n is Tween):
					n.removeWhiteOutline()
					n.getIntoMainLayer()
					n.updateLine()
					n.set_process(true)
			var _s1:=twn.interpolate_property(self,'scale',Vector2(1.5,0.5),Vector2(1,1),0.3,Tween.TRANS_BACK,Tween.EASE_OUT)
			var _s2:=twn.start()
