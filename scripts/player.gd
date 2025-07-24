extends CharacterBody2D


@export_subgroup("Nodes")
@export var gravityComponent: GravityComponent
@export var inputComponent: InputComponent
@export var movementComponent: MovementComponent
@export var animationComponent: AnimationComponent
@export var jumpComponent: JumpComponent

@onready var camera: Camera2D = $Camera2D

func _ready() -> void:
	if is_multiplayer_authority():
		camera.make_current()

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _physics_process(delta: float) -> void:
	if !is_multiplayer_authority(): return
	
	gravityComponent.handleGravity(self, delta)
	movementComponent.handleHorizontalMovement(self, inputComponent.inputHorizontal)
	animationComponent.handleMoveAnimation(inputComponent.inputHorizontal)
	jumpComponent.handleJump(self, inputComponent.getJumpInput())
	animationComponent.handleJumpAnimation(jumpComponent.isJumping, gravityComponent.isFalling)
	
	move_and_slide()
