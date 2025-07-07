class_name MovementComponent
extends Node

@export_subgroup("Settings")
@export var speed: float = 100

func handleHorizontalMovement(body: CharacterBody2D,direction: float) -> void:
	body.velocity.x = direction * speed
