# SPDX-FileCopyrightText: 2026 Tirth Kavathiya <tirthkavathiya@gmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.checkpoint_location = $Player.position
	Global.battery = float(Global.MAX)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
