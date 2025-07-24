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
		sprite.play(NetworkHandler.character + "_run")
	else:
		sprite.play(NetworkHandler.character + "_idle")

func handleJumpAnimation(isJumping: bool, isFalling: bool) -> void:
	if isJumping:
		sprite.play(NetworkHandler.character + "_jump")
	if isFalling:
		sprite.play(NetworkHandler.character + "_fall")
