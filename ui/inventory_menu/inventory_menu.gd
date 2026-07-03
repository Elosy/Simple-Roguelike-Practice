class_name InventoryMenu
extends CanvasLayer

signal item_selected(item)

const INVENTORY_MENU_ITEM_SCENE: Resource = preload("uid://dwk7s02vukj1")

@export var inventory_list: VBoxContainer
@export var title_label: Label


func _ready() -> void:
	hide()


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_back"):
		item_selected.emit(null)
		queue_free()


func button_pressed(item: Entity = null) -> void:
	item_selected.emit(item)
	queue_free()


func build(title_text: String, inventory: InventoryComponent) -> void:
	if inventory.items.is_empty():
		button_pressed.call_deferred()
		MessageLog.send_message("No items in inventory.", GameColors.IMPOSSIBLE)
		return
	title_label.text = title_text
	for i in inventory.items.size():
		_register_item(i, inventory.items[i])
	inventory_list.get_child(0).grab_focus()
	show()


func _register_item(index: int, item: Entity) -> void:
	var item_button: Button = INVENTORY_MENU_ITEM_SCENE.instantiate()
	# Get the character by alphabetical order.
	# In unicode, they are sorted that way, so we start with "a".
	var _char: String = String.chr("a".unicode_at(0) + index)
	item_button.text = "( %s ) %s" % [_char, item.get_entity_name()]
	var shortcut_event := InputEventKey.new()
	shortcut_event.keycode = KEY_A + index as Key
	item_button.shortcut = Shortcut.new()
	item_button.shortcut.events = [shortcut_event]
	item_button.pressed.connect(button_pressed.bind(item))
	inventory_list.add_child(item_button)
