class_name Map
extends Node2D

@export var fov_radius: int = 8
@export_group("Nodes")
@export var tiles: Node2D
@export var entities: Node2D
@export var dungeon_generator: DungeonGenerator
@export var field_of_view: FieldOfView

var map_data: MapData


func generate(player: Entity) -> void:
	map_data = dungeon_generator.generate_dungeon(player)
	map_data.entity_placed.connect(entities.add_child)
	_place_tiles()
	_place_entities()


func update_fov(player_position: Vector2i) -> void:
	field_of_view.update_fov(map_data, player_position, fov_radius)

	for entity in map_data.entities:
		entity.visible = map_data.get_tile(entity.grid_position).is_in_view


func load_game(player: Entity) -> bool:
	map_data = MapData.new(0, 0, player)
	map_data.entity_placed.connect(entities.add_child)
	if not map_data.load_game():
		return false
	_place_tiles()
	_place_entities()
	return true


#region private funcs
func _place_tiles() -> void:
	for tile in map_data.tiles:
		tiles.add_child(tile)


func _place_entities() -> void:
	for entity in map_data.entities:
		entities.add_child(entity)
