extends MultiplayerSpawner

@export var networkPlayer: PackedScene

func _ready() -> void:
	multiplayer.peer_connected.connect(spawnPlayer)
	
func spawnPlayer(id: int) -> void:
	if !multiplayer.is_server(): return
	
	var player: Node = networkPlayer.instantiate()
	player.name = str(id)
	
	get_node(spawn_path).call_deferred("add_child", player)
