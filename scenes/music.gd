extends AudioStreamPlayer
func _ready()->void:
	self.volume_db=-100
	set_process(true)
func _process(_d)->void:
	self.volume_db=lerp(self.volume_db,0,0.1)
	pass
