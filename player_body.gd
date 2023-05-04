extends CharacterBody3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var xsensitivity = 0.01
var Rotation = Vector2()
var speed = 4.0
const slowspeed = 1.0
const walkspeed = 4.0
const sprintspeed = 8.0

var mousemovement = Vector2()

var crouching = false
var backpedal = false
var mousecapture = true
var supported = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		Rotation.x -= (event.relative.x * xsensitivity)
		transform.basis = Basis()
		rotate_object_local(Vector3(0,1,0),Rotation.x)
	
	if Input.is_action_pressed("Crouch"):	
		if not crouching:
			$player_hitbox.shape.set_height(1.5)
			#$player_camera.set_v_offset(-0.5)
			transform.origin += Vector3(0,-0.5,0)
			crouching = true
	elif crouching:
		$player_hitbox.shape.set_height(2.0)
		#$player_camera.set_v_offset(0.0)
		transform.origin += Vector3(0,0.5,0.0)
		crouching = false
func _physics_process(delta):
	var direction = Vector3.ZERO
	backpedal = false
	if Input.is_action_pressed("Move Back"):
		direction += transform.basis.z
		backpedal = true
	if Input.is_action_pressed("Move Forward"):
		direction -= transform.basis.z
		backpedal = false
	if Input.is_action_pressed("Move Right"):
		direction += transform.basis.x
	if Input.is_action_pressed("Move Left"):
		direction -= transform.basis.x
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		if Input.is_action_pressed("Slow Walk"):
			speed = slowspeed
			if crouching:
				speed *= 0.8
			if backpedal:
				speed *= 0.8
		elif Input.is_action_pressed("Sprint"):
			speed = sprintspeed
			if crouching:
				speed *= 0.25
			if backpedal:
				speed *= 0.8
		else:
			speed = walkspeed
			if crouching:
				speed *= 0.5
			if backpedal:
				speed *= 0.8
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	move_and_slide()
	
	if not is_on_floor():
		velocity.y -= (delta * gravity)
	if Input.is_action_just_released("Jump") and is_on_floor():
		velocity.y += 7.0
