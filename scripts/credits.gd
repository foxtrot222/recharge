# SPDX-FileCopyrightText: 2026 Tirth Kavathiya <tirthkavathiya@gmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

extends ScrollContainer
@onready var text_node = $MarginContainer/RichTextLabel
@onready var margin = $MarginContainer
const CREDITS_TIME := 50.0
const MARGIN_INCREMENT := 0.0 
const MAIN_MENU := "uid://uuvc6sthec15"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	await get_tree().process_frame
	
	var window_size = get_viewport_rect().size.y
	margin.add_theme_constant_override("margin_top", window_size + MARGIN_INCREMENT)
	margin.add_theme_constant_override("margin_bottom", window_size + MARGIN_INCREMENT)
	
	var scroll_amount = int(get_v_scroll_bar().max_value)
	
	var tween = create_tween()
	tween.tween_property(self, "scroll_vertical", scroll_amount, CREDITS_TIME)
	tween.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file(MAIN_MENU)
	
