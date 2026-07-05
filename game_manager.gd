extends Node

const GAME_SCENE: PackedScene = preload("uid://5diwa0vg5tfm")
const MAIN_MENU_SCENE: PackedScene = preload("uid://bxau651bwsp0d")

var current_child: Node


func _ready():
	load_main_menu()


func switch_to_scene(scene: PackedScene) -> Node:
	if current_child != null:
		current_child.queue_free()
	current_child = scene.instantiate()
	add_child(current_child)
	return current_child


func load_main_menu() -> void:
	var main_menu: MainMenu = switch_to_scene(MAIN_MENU_SCENE)
	main_menu.game_requested.connect(_on_game_requested)


func _on_game_requested(try_load: bool) -> void:
	var game: GameRoot = switch_to_scene(GAME_SCENE)
	game.main_menu_requested.connect(load_main_menu)
