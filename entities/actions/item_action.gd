class_name ItemAction
extends Action

var item: Entity
var target_position: Vector2i


func _init(_entity: Entity, _item: Entity, _target_position = null) -> void:
	super._init(_entity)
	self.item = _item
	if _target_position is Vector2i:
		self.target_position = _target_position
	else:
		self.target_position = entity.grid_position



func get_target_actor() -> Entity:
	return get_map_data().get_actor_at_location(target_position)


func perform() -> bool:
	if item == null:
		return false
	return item.consumable_component.activate(self)
