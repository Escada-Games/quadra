extends KinematicBody2D
var vVelocity:=Vector2()
var fAngularSpeed:=PI

func _ready():
	randomize()
	self.modulate=global.aCurrentPal[4]
	#vVelocity.x = rand_range(2,10)*(randf()-0.5)
	#vVelocity.y = rand_range(-4,-16)#rand_range(-3,-8)
	#vVelocity = vVelocity.normalized()*rand_range(40,110)
	vVelocity = Vector2(0,-1).rotated(rand_range(-PI/4,PI/4))*rand_range(40,110)
	fAngularSpeed = rand_range(PI,3*PI)*(randf()-0.5)
	set_physics_process(true)
func _physics_process(delta):
	self.rotation+=fAngularSpeed*delta
	vVelocity.y += 4
	var _v1=move_and_slide(vVelocity,Vector2(0,-1))
	if self.global_position.y>512:self.queue_free()
	pass
