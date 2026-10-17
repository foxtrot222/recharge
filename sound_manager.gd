extends Control

func _ready() -> void:
	play_level_music()
	
func play_battery_sound():
	$SoundBattery.play()

func play_lose_sound():
	$SoundLose.play()

func play_button_sound():
	$SoundButton.play()

func play_jump_sound():
	$SoundJump.play()
	
func play_squash_sound():
	$SoundSquash.play()
	
func play_level_music():
	$MusicLevel.play()
	
func stop_level_music():
	$MusicLevel.stop()
	
func play_menu_music():
	$MusicMenu.play()
	
func stop_menu_music():
	$MusicMenu.stop()
