class_name LightningDamageConsumableComponent
extends ConsumableComponent

var damage: int = 0
var maximum_range: int = 0


func _init(definition: LightningDamageConsumableComponentDefinition) -> void:
	damage = definition.damage
	maximum_range = definition.maximum_range
