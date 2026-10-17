extends Node

const MAX = 100
const CHARGE = 25
const BAR = 112
const MOV_COST = 2
const JMP_COST = 5
const CAM_COST = 1

var battery := float(MAX)
var checkpoint_location := Vector3()
var vibrations := true
var rot_angle := 3.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if battery <= 0:
		battery = float(MAX)
		get_tree().change_scene_to_file("res://game_over_menu.tscn")
		
func checkpoint_save(location: Vector3):
	checkpoint_location = location


	
