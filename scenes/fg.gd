extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():set_process(true)
func _process(delta):
	self.global_position.x+=delta*10
	if self.global_position.x>=0:
		self.global_position.x=-8
