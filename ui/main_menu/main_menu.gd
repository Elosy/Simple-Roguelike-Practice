class_name MainMenu
extends Control

signal game_requested(load)

@export var first_button: Button
@export var load_button: Button


func _ready():
	first_button.grab_focus()
	var has_save_file: bool = FileAccess.file_exists("user://save_game.dat")
	load_button.disabled = not has_save_file


func _on_new_button_pressed():
	game_requested.emit(false)


func _on_load_button_pressed():
	game_requested.emit(true)


func _on_quit_button_pressed():
	get_tree().quit()
