extends Sprite2D

@onready var joystick: Control = $".."
@onready var ring: Sprite2D = $"../ring"
@onready var knob: Sprite2D = $"."


var pressing = false

@export var maxLength = 80
@export var deadZone = 5

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if DisplayServer.screen_get_size().x/4 >= event.position.x:
			joystick.global_position = event.position

func _ready() -> void:
	maxLength *= joystick.scale.x 

func _process(delta: float) -> void:
	if pressing and DisplayServer.screen_get_size().x/4 >= get_global_mouse_position().x:
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
		_on_button_released()

func calculateVector():
	if abs((global_position.x - joystick.global_position.x)) >= deadZone:
		joystick.posVector.x = (global_position.x - joystick.global_position.x)/maxLength 
	if abs((global_position.y - joystick.global_position.y)) >= deadZone:
		joystick.posVector.y = (global_position.y - joystick.global_position.y)/maxLength 


func _on_button_pressed() -> void:
	pressing = true
	ring.visible = true
	knob.visible = true


func _on_button_released() -> void:
	pressing = false
	ring.visible = false
	knob.visible = false
