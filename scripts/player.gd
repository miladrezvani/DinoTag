extends CharacterBody2D


@export_subgroup("Nodes")
@export var gravityComponent: GravityComponent
@export var inputComponent: InputComponent
@export var movementComponent: MovementComponent
@export var animationComponent: AnimationComponent
@export var jumpComponent: JumpComponent

@onready var camera: Camera2D = $Camera2D
@onready var flag: AnimatedSprite2D = $Flag
@onready var joystick: Control = $CanvasLayer/HBoxContainer/Joystick
@onready var timer: Timer = $Timer
@onready var time: Label = $CanvasLayer/Time
@onready var waitTimer: Timer = $WaitTimer
@onready var waitTimerLabel: Label = $CanvasLayer/WaitTimer
@onready var endTimer: Timer = $EndTimer

func _ready() -> void:
	if is_multiplayer_authority():
		camera.make_current()
		waitTimer.start()

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _physics_process(delta: float) -> void:
	if !is_multiplayer_authority(): return
	
	if NetworkHandler.mainFlag == self.name:
		flag.visible = true
	else:
		flag.visible = false
	if waitTimer.time_left != 0:
		waitTimerLabel.text = "%d" % waitTimer.time_left
	if timer.time_left != 0:
		time.text = "%d" % timer.time_left

	gravityComponent.handleGravity(self, delta)
	movementComponent.handleHorizontalMovement(self, inputComponent.inputHorizontal)
	animationComponent.handleMoveAnimation(inputComponent.inputHorizontal)
	jumpComponent.handleJump(self, inputComponent.getJumpInput())
	animationComponent.handleJumpAnimation(jumpComponent.isJumping, gravityComponent.isFalling)
	
	move_and_slide()

func _on_timer_timeout() -> void:
	if !is_multiplayer_authority(): return
	joystick.visible = false
	var peers = multiplayer.get_peers()
	for id in peers:
		if str(id) != NetworkHandler.mainFlag:
			rpc("switchCameraToLoser")
	endTimer.start()

func _on_wait_timer_timeout() -> void:
	waitTimerLabel.text = ""
	joystick.visible = true
	timer.wait_time = NetworkHandler.setTimer
	timer.start()

func _on_end_timer_timeout() -> void:
	if !is_multiplayer_authority(): return
	if multiplayer.is_server():
		NetworkHandler.rpc("changeScene")

@rpc("any_peer")
func switchCameraToLoser() -> void:
	camera.make_current()
	

func _on_area_detector_area_entered(area: Area2D) -> void:
	var otherCharacter = area.get_parent() as CharacterBody2D
	if otherCharacter == null:
		print("There is no other player")
		
	if flag.visible or otherCharacter.flag.visible:
		NetworkHandler.rpc("handleFlag",self.flag.visible, otherCharacter.flag.visible, self.name, otherCharacter.name)
