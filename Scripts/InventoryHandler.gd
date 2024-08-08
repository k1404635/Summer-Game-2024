extends Node
class_name InentoryHandler

@export var ItemSlotsCount : int = 1
@export var InventoryGrid : GridContainer
@export var InventorySlotPrefab : PackedScene = preload("res://Scenes/Inventory_Slot.tscn")

var InventorySlots : Array[InventorySlot] = []

func _ready() -> void:
	for i in ItemSlotsCount:
		var slot = InventorySlotPrefab.instantiate() as InventorySlot
		InventoryGrid.add_child(slot)
		slot.InventorySlotID = i
		InventorySlots.append(slot)

func PickupItem(item : ItemData):
	for slot in InventorySlots:
		if(!slot.SlotFilled):
			slot.FillSlot(item)
			break

func DropItem(item : ItemData):
	for slot in InventorySlots:
		if(slot.SlotFilled):
			slot.ClearSlot(item)
