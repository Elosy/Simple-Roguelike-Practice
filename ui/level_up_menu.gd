class_name LevelUpMenu
extends CanvasLayer

signal level_up_completed

@export var health_upgrade_button: Button
@export var power_upgrade_button: Button
@export var defense_upgrade_button: Button

var player: Entity


func setup(_player: Entity) -> void:
	player = _player
	var fighter: FighterComponent = player.fighter_component
	health_upgrade_button.text = "(a) Constitution (+20 HP, from %d)" % fighter.max_hp
	power_upgrade_button.text = "(b) Strength (+1 attack, from %d)" % fighter.power
	defense_upgrade_button.text = "(c) Agility (+1 defense, from %d)" % fighter.defense
	health_upgrade_button.grab_focus()


#region private funcs
func _on_health_upgrade_button_pressed() -> void:
	player.level_component.increase_max_hp()
	queue_free()
	level_up_completed.emit()


func _on_power_upgrade_button_pressed() -> void:
	player.level_component.increase_power()
	queue_free()
	level_up_completed.emit()


func _on_defence_upgrade_button_pressed() -> void:
	player.level_component.increase_defence()
	queue_free()
	level_up_completed.emit()
