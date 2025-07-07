class_name AnimationComponent
extends Node

@export_subgroup("Nodes")
@export var sprite: AnimatedSprite2D

func handleHorizontalFlip(moveDirection: float) -> void:
	if moveDirection == 0:
		return
	sprite.flip_h = false if moveDirection > 0 else true
	

func handleMoveAnimation(moveDirection: float) -> void:
	handleHorizontalFlip(moveDirection)
	
	if moveDirection != 0:
		sprite.play("run")
	else:
		sprite.play("idle")

func handleJumpAnimation(isJumping: bool, isFalling: bool) -> void:
	if isJumping:
		sprite.play("jump")
	if isFalling:
		sprite.play("fall")
