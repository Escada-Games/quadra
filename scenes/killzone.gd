extends Area2D
var lineFx:=preload("res://scenes/lineFx.tscn")
var sfxFall:=preload("res://scenes/sfxPieceFall.tscn")
var sfxFallAlt:=preload("res://scenes/sfxPieceFallAlt.tscn")
func _ready()->void:
	var _s1:=self.connect("body_entered",self,'deleteBody')
func deleteBody(b:PhysicsBody2D)->void:
	if b is RigidBody2D and not global.bInvulnerable:
		global.bInvulnerable = true
		global.iLifes-=1
		var i=lineFx.instance()
		i.bLineScore=false
		i.rotation+=PI/2
		i.global_position=b.global_position
		global.minorShake()
		get_parent().add_child(i)
		b.remove()
		global.add_child(sfxFall.instance())
		global.add_child(sfxFallAlt.instance())
	else:
		b.queue_free()
