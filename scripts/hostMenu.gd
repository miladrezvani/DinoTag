extends Control

@onready var playerId: Label = $PlayerID

func _process(delta: float) -> void:
	var players = multiplayer.get_peers()
	var result = "Players ID: \n---"
	if !players.is_empty():
		for id in players:
			result += "\n" + str(id) + "\n---"
		playerId.text = result
			

func _on_start_pressed() -> void:
	pass # Replace with function body.


func _on_back_pressed() -> void:
	
	get_tree().change_scene_to_file("res://scenes/menu/main.tscn")
