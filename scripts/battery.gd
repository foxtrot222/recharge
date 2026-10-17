# SPDX-FileCopyrightText: 2026 Tirth Kavathiya <tirthkavathiya@gmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

extends Area3D

const ROT_SPEED = 2 # Number of degrees the coin rotates every frame
@export var hud : CanvasLayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	rotate_y(deg_to_rad(ROT_SPEED))

func _on_body_entered(_body: Node3D) -> void:
	if Global.battery + Global.CHARGE > Global.MAX:
		Global.battery = Global.MAX
	else:
		Global.battery += Global.CHARGE
		
	SoundManager.play_battery_sound()
	hud.get_node("BatteryLabel").text = str(int(Global.battery))
	hud.get_node("BatteryBar").size.x = Global.BAR * ( float(Global.battery) / Global.MAX )
	
	set_collision_layer_value(3, false)
	set_collision_mask_value(1,false)
	
	$AnimationPlayer.play("bounce")

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()
