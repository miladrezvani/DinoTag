extends MultiplayerSpawner

@export var networkPlayer: PackedScene

func _ready() -> void:
	if multiplayer.has_multiplayer_peer():
		var players = multiplayer.get_peers()
		for id in players:
			spawnPlayer(id)
	spawnPlayer(multiplayer.get_unique_id())
	
func spawnPlayer(id: int) -> void:
	if !multiplayer.is_server(): return
	
	var player: Node = networkPlayer.instantiate()
	player.name = str(id)
	
	get_node(spawn_path).call_deferred("add_child", player)
