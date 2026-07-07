class_name GameRoot
extends Control

signal main_menu_requested

@export var game: Game


func _ready() -> void:
	SignalBus.escape_requested.connect(_on_escape_requested)


func new_game() -> void:
	game.new_game()


#region save/load
func load_game() -> void:
	if not game.load_game():
		main_menu_requested.emit()


#region private funcs
func _on_escape_requested() -> void:
	main_menu_requested.emit()
