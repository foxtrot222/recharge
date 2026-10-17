# SPDX-FileCopyrightText: 2026 Tirth Kavathiya <tirthkavathiya@gmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

extends Area3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	rotate_y(deg_to_rad(3))


func _on_body_entered(_body: Node3D) -> void:
	Global.checkpoint_save(position)
	queue_free()
