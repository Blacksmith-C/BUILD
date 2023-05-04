extends Camera3D

var ysensitivity = 0.01
var Rotation = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if Input.is_action_just_released("Mouse Capture Toggle"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		Rotation.y -= (event.relative.y * ysensitivity)
		Rotation.y = clamp(Rotation.y,-PI/2,PI/2)
		transform.basis = Basis()
		rotate_object_local(Vector3(1,0,0),Rotation.y)
		
