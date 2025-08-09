extends Sprite2D

@onready var joystick: Control = $".."


var pressing = false

@export var maxLength = 80
@export var deadZone = 5

func _ready() -> void:
	maxLength *= joystick.scale.x 

func _process(delta: float) -> void:
	if pressing:
		if get_global_mouse_position().distance_to(joystick.global_position) <= maxLength:
			global_position = get_global_mouse_position()
		else:
			var angle = joystick.global_position.angle_to_point(get_global_mouse_position())
			global_position.x = joystick.global_position.x + cos(angle)*maxLength
			global_position.y = joystick.global_position.y + sin(angle)*maxLength
		calculateVector()
	else:
		global_position = lerp(global_position, joystick.global_position, delta*10)
		joystick.posVector = Vector2(0,0)
	print(joystick.posVector)

func calculateVector():
	if abs((global_position.x - joystick.global_position.x)) >= deadZone:
		joystick.posVector.x = (global_position.x - joystick.global_position.x)/maxLength 
	if abs((global_position.y - joystick.global_position.y)) >= deadZone:
		joystick.posVector.y = (global_position.y - joystick.global_position.y)/maxLength 

func _on_button_button_down() -> void:
	pressing = true


func _on_button_button_up() -> void:
	pressing = false
