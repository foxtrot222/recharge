# SPDX-FileCopyrightText: 2026 Tirth Kavathiya <tirthkavathiya@gmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 12

const WIN_MENU_SCENE := "uid://d1teu4tp5h24b"

var xform : Transform3D
var jumped = false

func _physics_process(delta: float) -> void:
	
	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Play robot animations
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		$AnimationPlayer.play("jump")
	elif is_on_floor() and input_dir != Vector2(0,0):
		$AnimationPlayer.play("run")
	elif is_on_floor() and input_dir == Vector2(0,0):
		$AnimationPlayer.play("idle")
	
		
	# Rotate the camera left or right
	if Input.is_action_pressed("cam_left"):
		$Camera_Controller.rotate_y(deg_to_rad(Global.rot_angle))

	if Input.is_action_pressed("cam_right"):
		$Camera_Controller.rotate_y(deg_to_rad(-Global.rot_angle))
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		SoundManager.play_jump_sound()
		if Global.vibrations:
			Input.start_joy_vibration(0, 0.15, 0, 0.05)
		velocity.y = JUMP_VELOCITY
		Global.battery -= Global.JMP_COST
		jumped = true

	if jumped and not velocity.y:
		jumped = false
		if Global.vibrations:
			Input.start_joy_vibration(0, 0.2, 0.15, 0.15)
		
	if input_dir != Vector2.ZERO:
		Global.battery -= Global.MOV_COST * delta
	
	var direction = ($Camera_Controller.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# Rotate the character mesh so oriented towards the direction moving in relation to the camera
	if input_dir != Vector2(0,0):
		$Armature.rotation_degrees.y = $Camera_Controller.rotation_degrees.y - rad_to_deg(input_dir.angle()) -90
		
	# Rotate the character to align with the floor
	if is_on_floor():
		align_with_floor($RayCast3D.get_collision_normal())
		global_transform = global_transform.interpolate_with(xform, 0.3)
	elif not is_on_floor():
		align_with_floor(Vector3.UP)
		global_transform = global_transform.interpolate_with(xform, 0.3)
		
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	# Update the hud after taking Input
	var hud = get_tree().current_scene.get_node("HUD")
	hud.get_node("BatteryLabel").text = str(int(Global.battery))
	hud.get_node("BatteryBar").size.x = Global.BAR * ( float(Global.battery) / Global.MAX )
	
	# Make Camera Controller match the position of player 'smoothly'
	$Camera_Controller.position = lerp($Camera_Controller.position, position, 0.15)
	
func align_with_floor(floor_normal):
	xform = global_transform
	xform.basis.y = floor_normal
	xform.basis.x = -xform.basis.z.cross(floor_normal)
	xform.basis = xform.basis.orthonormalized()


func _on_fall_zone_body_entered(body: Node3D) -> void:
	jumped = false
	SoundManager.play_lose_sound()
	if Global.vibrations:
		Input.start_joy_vibration(0, 0, 0.5, 0.2)
	body.position = Global.checkpoint_location
	
	
func bounce():
	velocity.y = JUMP_VELOCITY * 0.7 

func _on_finish_point_body_entered(_body: Node3D) -> void:
	get_tree().change_scene_to_file(WIN_MENU_SCENE)
