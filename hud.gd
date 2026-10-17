extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$BatteryLabel.text = str(Global.MAX)
	$BatteryBar.size.x = Global.BAR
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
