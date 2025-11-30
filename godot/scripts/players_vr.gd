extends CharacterBody3D

@onready var head_controls:Camera3D = $head_controls
@onready var VR_viewport:Camera3D = $eyes_sockets/VR_viewport

#vr var
var gyro_sensitivity:float = 0.05
var gyroscope_direction:Vector3
var garvity_direction:Vector3 = Vector3.ZERO

#joystick var
var right_sticks:Vector2
var left_sticks:Vector2

#character 3D physics const (changable for debug so will not used const)
var char_garvity:float = 9.81
var char_speed:float = 0.125
var char_jump_height:float = 4.5
var direction:Vector2
var rotation_speed:float = 0.015

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("X") and is_on_floor_only():
		velocity.y += char_jump_height

func _physics_process(delta: float) -> void:
	#var setting
	right_sticks = Input.get_vector("right_stick_left","right_stick_right","right_stick_up","right_stick_down")
	left_sticks = Input.get_vector("left_stick_left","left_stick_right","left_stick_up","left_stick_down")
	var input:Vector3 = transform.basis * Vector3(left_sticks.x,0,left_sticks.y).normalized()
	
	#if-else statements for movements
	if !is_on_floor_only():
		velocity.y -= char_garvity * delta
		
	#controller handled
	if right_sticks:
		rotate_y(right_sticks.x * -rotation_speed)
	if left_sticks:
		velocity.z += char_speed * input.z
		velocity.x += char_speed * input.x
	else:
		velocity.x = lerpf(velocity.x,0,char_garvity*delta)
		velocity.z = lerpf(velocity.z,0,char_garvity*delta)
	
	#func updated
	move_and_slide()
	gyroscope_handled()
	garvity_Y_alignments()
	VR_Viewport_updated()
	
func garvity_Y_alignments() -> void:
	garvity_direction = Input.get_gravity()
	
	if garvity_direction != Vector3.ZERO:
		head_controls.position.y += garvity_direction.y
	
	head_controls.position.y = clamp(head_controls.position.y,0, 1)
	
func gyroscope_handled() -> void: #gyro handled in androidVR
	#var
	gyroscope_direction = Input.get_gyroscope()

	#gyroscope handled
	if gyroscope_direction != Vector3.ZERO:
		head_controls.rotate_x(gyroscope_direction.x * gyro_sensitivity) #heads look up-down
		rotate_y((gyroscope_direction.y * gyro_sensitivity)/2) #heads look left-right
		if Global.head_tilt:
			head_controls.rotate_z((gyroscope_direction.z * (gyro_sensitivity/2))/2)
	
	#clamp shi
	head_controls.rotation_degrees.x = clamp(head_controls.rotation_degrees.x,-90,90)
	head_controls.rotation_degrees.z = clamp(head_controls.rotation_degrees.z,-80,80)

func VR_Viewport_updated() -> void: #update position and rotation of VR_viewport node
	VR_viewport.global_position = head_controls.global_position
	VR_viewport.global_rotation = head_controls.global_rotation

func _on_centered_button_pressed() -> void: #setting zero all rotation (except y) and y_axis pos
	head_controls.rotation.x = 0
	head_controls.rotation.z = 0
	head_controls.position.y = 0.5
