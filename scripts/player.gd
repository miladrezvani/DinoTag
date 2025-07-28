extends CharacterBody2D


@export_subgroup("Nodes")
@export var gravityComponent: GravityComponent
@export var inputComponent: InputComponent
@export var movementComponent: MovementComponent
@export var animationComponent: AnimationComponent
@export var jumpComponent: JumpComponent

@onready var camera: Camera2D = $Camera2D
@onready var flag: Sprite2D = $Flag
func _ready() -> void:
	if is_multiplayer_authority():
		camera.make_current()

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _physics_process(delta: float) -> void:
	if !is_multiplayer_authority(): return
	
	if NetworkHandler.mainFlag == self.name:
		flag.visible = true
	else:
		flag.visible = false

	gravityComponent.handleGravity(self, delta)
	movementComponent.handleHorizontalMovement(self, inputComponent.inputHorizontal)
	animationComponent.handleMoveAnimation(inputComponent.inputHorizontal)
	jumpComponent.handleJump(self, inputComponent.getJumpInput())
	animationComponent.handleJumpAnimation(jumpComponent.isJumping, gravityComponent.isFalling)
	
	move_and_slide()


func _on_area_detector_area_exited(area: Area2D) -> void:
	var otherCharacter = area.get_parent() as CharacterBody2D
	if otherCharacter == null:
		print("There is no other player")
		
	if flag.visible or otherCharacter.flag.visible:
		NetworkHandler.rpc("handleFlag",self.flag.visible, otherCharacter.flag.visible, self.name, otherCharacter.name)
