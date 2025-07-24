extends Node

func _on_host_pressed() -> void:
	NetworkHandler.startServer()


func _on_join_pressed() -> void:
	NetworkHandler.character = "vita"
	NetworkHandler.startClient()
