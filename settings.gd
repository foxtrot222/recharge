extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CheckButton.button_pressed = Global.vibrations
	$Rot.text = str(Global.rot_angle) + "*"
	$HSlider.value = Global.rot_angle
	$Vib.text = "On" if Global.vibrations else "Off"


func _on_play_pressed() -> void:
	SoundManager.play_button_sound()
	SoundManager.stop_menu_music()
	SoundManager.play_level_music()
	get_tree().change_scene_to_file("res://level.tscn")


func _on_check_button_toggled(toggled_on: bool) -> void:
	Global.vibrations = toggled_on
	$Vib.text = "On" if Global.vibrations else "Off"


func _on_h_slider_value_changed(value: float) -> void:
	Global.rot_angle = value
	$Rot.text = str(int(value)) + "*"
