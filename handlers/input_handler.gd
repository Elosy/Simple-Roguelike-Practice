class_name InputHandler
extends Node

enum InputHandlers {MAIN_GAME, GAME_OVER, HISTORY_VIEWER}

@export var starter_input_handler: InputHandlers
@export var input_handler_nodes: Dictionary[InputHandlers, Node]

var current_input_handler: BaseInputHandler


func _ready() -> void:
	transition_to(starter_input_handler)
	SignalBus.player_died.connect(transition_to.bind(InputHandlers.GAME_OVER))


func get_action(player: Entity) -> Action:
	return current_input_handler.get_action(player)


func transition_to(input_handler: InputHandlers) -> void:
	if current_input_handler != null:
		current_input_handler.exit()
	current_input_handler = input_handler_nodes[input_handler]
	current_input_handler.enter()
