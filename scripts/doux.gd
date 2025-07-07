extends CharacterBody2D


@export_subgroup("Nodes")
@export var gravityComponent: GravityComponent
@export var inputComponent: InputComponent
@export var movementComponent: MovementComponent
@export var animationComponent: AnimationComponent
@export var jumpComponent: JumpComponent

func _physics_process(delta: float) -> void:
	gravityComponent.handleGravity(self, delta)
	movementComponent.handleHorizontalMovement(self, inputComponent.inputHorizontal)
	animationComponent.handleMoveAnimation(inputComponent.inputHorizontal)
	jumpComponent.handleJump(self, inputComponent.getJumpInput())
	animationComponent.handleJumpAnimation(jumpComponent.isJumping, gravityComponent.isFalling)
	
	move_and_slide()
