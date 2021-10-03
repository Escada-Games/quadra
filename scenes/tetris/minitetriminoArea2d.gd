extends Area2D

func _ready():
	var _s1=self.connect("body_entered",self,'bodyEntered')
	set_process(false)
	
func bodyEntered(b):
	if b!=get_parent().get_parent():
		if (b is RigidBody2D) or (b is StaticBody2D):
			get_parent().get_parent().bodyEntered(b)

func deleteSelf():
	#get_parent().get_parent().apply_central_impulse(Vector2(0,1))
	get_parent().deleteSelf()
