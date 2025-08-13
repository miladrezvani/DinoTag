extends Control

@onready var playerId: Label = $PlayerID

func _process(delta: float) -> void:
	var players = multiplayer.get_peers()
	var result = "Players ID: \n---"
	if !players.is_empty():
		for id in players:
			result += "\n" + str(id) + "\n---"
		playerId.text = result
	if players:
		var randomId = randi() % players.size()
		var randomFlag = players[randomId]
		NetworkHandler.rpc("updateTimer",NetworkHandler.setTimer)
		NetworkHandler.rpc("updateFlag", str(randomFlag))

func _on_start_pressed() -> void:
	NetworkHandler.rpc("startGame", true)
	get_tree().change_scene_to_file("res://scenes/map/theJailOfAzkaban.tscn")


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/main.tscn")


func _on_timer_90_pressed() -> void:
	NetworkHandler.rpc("updateTimer", 90)


func _on_timer_120_pressed() -> void:
	NetworkHandler.rpc("updateTimer", 120)


func _on_timer_150_pressed() -> void:
	NetworkHandler.rpc("updateTimer", 150)


func _on_timer_180_pressed() -> void:
	NetworkHandler.rpc("updateTimer", 180)


func _on_timer_210_pressed() -> void:
	NetworkHandler.rpc("updateTimer", 210)


func _on_timer_240_pressed() -> void:
	NetworkHandler.rpc("updateTimer", 240)
