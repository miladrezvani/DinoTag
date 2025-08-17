extends Control

@onready var playerId: Label = $PlayerID

@onready var theJailOfAzkaban: Button = $VBoxContainer2/HBoxContainer/TheJailOfAzkaban
@onready var arrakeenSand: Button = $VBoxContainer2/HBoxContainer/ArrakeenSand
@onready var woodenMaze: Button = $VBoxContainer2/HBoxContainer/WoodenMaze

func _process(delta: float) -> void:
	
	theJailOfAzkaban.modulate.a8 = 200 if NetworkHandler.setMap == "res://scenes/map/theJailOfAzkaban.tscn" else 255
	arrakeenSand.modulate.a8 = 200 if NetworkHandler.setMap == "res://scenes/map/ArrakeenSand.tscn" else 255
	woodenMaze.modulate.a8 = 200 if NetworkHandler.setMap == "res://scenes/map/WoodenMaze.tscn" else 255
	
	var players = multiplayer.get_peers()
	var result = "Players ID: \n---"
	if players:
		for id in players:
			result += "\n" + str(id) + "\n---"
		playerId.text = result
		var randomId = randi() % players.size()
		var randomFlag = players[randomId]
		NetworkHandler.rpc("updateMap", NetworkHandler.setMap)
		NetworkHandler.rpc("updateTimer",NetworkHandler.setTimer)
		NetworkHandler.rpc("updateFlag", str(randomFlag))

func _on_start_pressed() -> void:
	NetworkHandler.rpc("startGame", true)
	get_tree().change_scene_to_file(NetworkHandler.setMap)


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


func _on_the_jail_of_azkaban_pressed() -> void:
	NetworkHandler.setMap = "res://scenes/map/theJailOfAzkaban.tscn"

func _on_arrakeen_sand_pressed() -> void:
	NetworkHandler.setMap = "res://scenes/map/ArrakeenSand.tscn"


func _on_wooden_maze_pressed() -> void:
	NetworkHandler.setMap = "res://scenes/map/WoodenMaze.tscn"
