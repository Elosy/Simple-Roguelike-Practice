class_name InventoryMenu
extends CanvasLayer

signal item_selected(item)

const inventory_menu_item_scene: Resource = preload("uid://dwk7s02vukj1")

@export var inventory_list: VBoxContainer 
@export var title_label: Label 
