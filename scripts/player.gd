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
@onready var winOrLose: Label = $CanvasLayer/WinorLose
@onready var touchScreenButton: TouchScreenButton = $CanvasLayer/HBoxContainer2/TouchScreenButton

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
		waitTimerLabel.text = "%d" % (waitTimer.time_left + 1)
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
	touchScreenButton.visible = false
	match NetworkHandler.character:
		"doux":
			winOrLose.label_settings.font_color = Color.html("#4D92BC")
		"mort":
			winOrLose.label_settings.font_color = Color.html("#BC4D4F")
		"tard":
			winOrLose.label_settings.font_color = Color.html("#FDC760")
		"vita":
			winOrLose.label_settings.font_color = Color.html("#9FBC4D")
	if flag.visible:
		winOrLose.text = "LOSER"
	else:
		winOrLose.text = "WINER"
	endTimer.start()

func _on_wait_timer_timeout() -> void:
	waitTimerLabel.text = ""
	joystick.visible = true
	touchScreenButton.visible = true
	timer.wait_time = NetworkHandler.setTimer
	timer.start()

func _on_end_timer_timeout() -> void:
	if !is_multiplayer_authority(): return
	if multiplayer.is_server():
		NetworkHandler.rpc("changeScene")

func _on_area_detector_area_entered(area: Area2D) -> void:
	var otherCharacter = area.get_parent() as CharacterBody2D
	if otherCharacter == null:
		print("There is no other player")
		
	if flag.visible or otherCharacter.flag.visible:
		NetworkHandler.rpc("handleFlag",self.flag.visible, otherCharacter.flag.visible, self.name, otherCharacter.name)
