class_name Game
extends Node2D

signal player_created(player)

const player_definition: EntityDefinition = preload("uid://e00r0wcbw55p")

@export var player: Entity
@export var input_handler: InputHandler
@export var map: Map
@export var camera: Camera2D


func _ready() -> void:
	player = Entity.new(null, Vector2i.ZERO, player_definition)
	player_created.emit(player)
	remove_child(camera)
	player.add_child(camera)
	map.generate(player)
	map.update_fov(player.grid_position)
	MessageLog.send_message.bind(
		"Hello and welcome, adventurar, to yet another dungeon!",
		GameColors.WELCOME_TEXT
	).call_deferred()


func _physics_process(_delta: float) -> void:
	var action: Action = await input_handler.get_action(player)
	if action:
		var previous_player_position: Vector2i = player.grid_position
		if action.perform():
			_handle_enemy_turns()
			if player.grid_position != previous_player_position:
				map.update_fov(player.grid_position)


func get_map_data() -> MapData:
	return map.map_data


func _handle_enemy_turns() -> void:
	for entity in get_map_data().get_actors():
		if entity.is_alive() and entity != player:
			entity.ai_component.perform()
