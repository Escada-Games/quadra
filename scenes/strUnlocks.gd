extends Label
func _ready()->void:set_process(true)
func _process(_d)->void:self.text = str(global.iUnlocks)+' out of 10'
