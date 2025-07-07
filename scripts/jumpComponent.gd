class_name JumpComponent
extends Node


@export_subgroup("Settings")
@export var jumpVelocity: float = -350.0

var isJumping: bool = false

func handleJump(body:CharacterBody2D, wantToJump: bool) -> void:
	if wantToJump and body.is_on_floor():
		body.velocity.y = jumpVelocity
	
	isJumping = body.velocity.y < 0 and not body.is_on_floor()
