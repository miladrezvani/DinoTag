class_name InputComponent
extends Node

@onready var joystick: Control = $"../CanvasLayer/HBoxContainer/Joystick"

var inputHorizontal: float = 0.0

func _process(delta: float) -> void:
	inputHorizontal = joystick.posVector.x

func getJumpInput() -> bool:
	return Input.is_action_just_pressed("up")
