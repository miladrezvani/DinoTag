extends Node

const ipAddress: String = "localhost"
const port: int = 42069

var peer: ENetMultiplayerPeer

func startServer() -> void:
	peer = ENetMultiplayerPeer.new()
	peer.create_server(port)
	multiplayer.multiplayer_peer = peer
	
	var my_id = multiplayer.get_unique_id()
	multiplayer.emit_signal("peer_connected", my_id)
	
func startClient() -> void:
	peer = ENetMultiplayerPeer.new()
	peer.create_client(ipAddress,port)
	multiplayer.multiplayer_peer = peer
	
