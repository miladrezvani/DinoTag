class_name InputComponent
extends Node

var inputHorizontal: float = 0.0

func _process(delta: float) -> void:
	inputHorizontal = Input.get_axis("left","right")

func getJumpInput() -> bool:
	return Input.is_action_just_pressed("up")
