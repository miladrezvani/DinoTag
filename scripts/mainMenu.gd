extends Control

func _on_host_pressed() -> void:
	NetworkHandler.resetConnection()
	NetworkHandler.startServer()
	get_tree().change_scene_to_file("res://scenes/menu/host.tscn")


func _on_join_pressed() -> void:
	NetworkHandler.resetConnection()
	NetworkHandler.startClient()
	get_tree().change_scene_to_file("res://scenes/menu/join.tscn")
