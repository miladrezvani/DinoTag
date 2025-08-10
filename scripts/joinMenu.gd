extends Control

@onready var status: Label = $Status

func _process(delta: float) -> void:
	var statusCode = multiplayer.multiplayer_peer.get_connection_status()
	if statusCode == multiplayer.multiplayer_peer.CONNECTION_CONNECTED:
		status.text = "Connected"
	elif statusCode == multiplayer.multiplayer_peer.CONNECTION_CONNECTING:
		status.text = "Connecting..."
	else:
		status.text = "Disconnected"
	

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/main.tscn")
