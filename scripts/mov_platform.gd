# SPDX-FileCopyrightText: 2026 Tirth Kavathiya <tirthkavathiya@gmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

extends AnimatableBody3D

@export var a := Vector3()
@export var b := Vector3()
@export var time : float = 2.0
@export var pause : float = 0.7


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move()

func move():
	var mov_tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	mov_tween.set_loops()
	mov_tween.tween_property(self, "position", b, time).set_trans(Tween.TRANS_CUBIC).set_delay(pause)
	mov_tween.tween_property(self, "position", a, time).set_trans(Tween.TRANS_CUBIC).set_delay(pause)
	await await mov_tween.finished
	
