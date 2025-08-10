extends Control

@onready var doux: Button = $HBoxContainer/doux
@onready var mort: Button = $HBoxContainer/mort
@onready var tard: Button = $HBoxContainer/tard
@onready var vita: Button = $HBoxContainer/vita

func _process(delta: float) -> void:
	doux.modulate.a8 = 200 if NetworkHandler.character == "doux" else 255
	mort.modulate.a8 = 200 if NetworkHandler.character == "mort" else 255
	tard.modulate.a8 = 200 if NetworkHandler.character == "tard" else 255
	vita.modulate.a8 = 200 if NetworkHandler.character == "vita" else 255
	

func _on_doux_pressed() -> void:
	NetworkHandler.character = "doux"

func _on_mort_pressed() -> void:
	NetworkHandler.character = "mort"

func _on_tard_pressed() -> void:
	NetworkHandler.character = "tard"

func _on_vita_pressed() -> void:
	NetworkHandler.character = "vita"
