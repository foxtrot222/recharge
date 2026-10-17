# SPDX-FileCopyrightText: 2026 Tirth Kavathiya <tirthkavathiya@gmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

extends Control

const LEVEL_SCENE := "uid://c115r8mocvqq8"
const SETTINGS_SCENE := "uid://cax8rud1l6uym"
const CREDITS := "uid://dmaklpuxe7opo"

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
	get_tree().change_scene_to_file(LEVEL_SCENE)


func _on_settings_pressed() -> void:
	SoundManager.play_button_sound()
	get_tree().change_scene_to_file(SETTINGS_SCENE)


func _on_credits_pressed() -> void:
	SoundManager.play_button_sound()
	get_tree().change_scene_to_file(CREDITS)
