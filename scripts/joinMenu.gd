extends Control

@onready var status: Label = $Status

func _process(delta: float) -> void:
	if multiplayer.multiplayer_peer:
		var statusCode = multiplayer.multiplayer_peer.get_connection_status()
		if statusCode == multiplayer.multiplayer_peer.CONNECTION_CONNECTED:
			status.text = "Connected"
		elif statusCode == multiplayer.multiplayer_peer.CONNECTION_CONNECTING:
			status.text = "Connecting..."
		else:
			status.text = "Disconnected"

	if NetworkHandler.startPressed:
		get_tree().change_scene_to_file("res://scenes/map/theJailOfAzkaban.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/main.tscn")
