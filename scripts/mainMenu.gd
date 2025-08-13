extends Control

func _ready() -> void:
	if multiplayer.has_multiplayer_peer():
		NetworkHandler.rpc("resetConnection")

func _on_host_pressed() -> void:
	NetworkHandler.startServer()
	get_tree().change_scene_to_file("res://scenes/menu/host.tscn")


func _on_join_pressed() -> void:
	NetworkHandler.startClient()
	get_tree().change_scene_to_file("res://scenes/menu/join.tscn")
