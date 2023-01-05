extends Control

func _on_Start_pressed():
	get_tree().change_scene("res://GameObjects/GameScenes/SolarView/SolarView.tscn")
	UnitManager.init_initial_units()


func _on_Exit_pressed():
	get_tree().quit()
