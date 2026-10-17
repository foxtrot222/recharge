extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SoundManager.play_menu_music()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("start"):
		_on_button_pressed()


func _on_button_pressed() -> void:
	SoundManager.play_button_sound()
	SoundManager.stop_menu_music()
	SoundManager.play_level_music()
	get_tree().change_scene_to_file("res://level.tscn")


func _on_settings_pressed() -> void:
	SoundManager.play_button_sound()
	get_tree().change_scene_to_file("res://settings.tscn")
