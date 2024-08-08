extends Area2D

signal OnItemPickedUp(item)
signal OnItemDropped(item)

@export var ItemTypes : Array[ItemData] = []

var NearbyBodies : Array[InteractableItem]
@export var itemsInInventory = 0

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("Pickup or Put down")):
		if itemsInInventory == 1:
			PutDown()
		else:
			Pickup()
		
func Pickup():
	var nearestItem : InteractableItem = null
	var nearestDistance : float = INF
	for item in NearbyBodies:
		if(item.global_position.distance_to(global_position) < nearestDistance):
			nearestDistance = item.global_position.distance_to(global_position)
			nearestItem = item
		
		if nearestItem != null and itemsInInventory == 0:
			nearestItem.queue_free()
			NearbyBodies.remove_at(NearbyBodies.find(nearestItem))
			var itemPrefab = nearestItem.scene_file_path
			for i in ItemTypes.size():
				if(ItemTypes[i].ItemModelPrefab != null and ItemTypes[i].ItemModelPrefab.resource_path == itemPrefab):
					print("Item id:" + str(i) + " Item Name: " + ItemTypes[i].ItemName)
					itemsInInventory += 1
					OnItemPickedUp.emit(ItemTypes[i])
					return
				
				printerr("Item not found") 

func PutDown(): # FIX THIS METHOD AFTER FIGURING OUT HOW TO DO THE TABLE INTERACTION INSTEAD OF INDIVIDUAL ITEMS
	if(!NearbyBodies.is_empty()): # need to put everything below in this if statement probs??
		pass
		
	#change the item parts to fit the tables instead of items
	var nearestItem : InteractableItem = null
	var nearestDistance : float = INF
	for item in NearbyBodies:
		if(item.global_position.distance_to(global_position) < nearestDistance):
			nearestDistance = item.global_position.distance_to(global_position)
			nearestItem = item
		
		if nearestItem != null and itemsInInventory == 1:
			nearestItem.queue_free() #instead of queue_free, create the corresponding food image on the table
			NearbyBodies.remove_at(NearbyBodies.find(nearestItem))
			var itemPrefab = nearestItem.scene_file_path #this would need to change based on what's currently in the inventory and not based on the nearestItem
			for i in ItemTypes.size(): # i could probs keep this as itemTypes, but need to make a table/tile types or something that is similar to itemtypes for the rest of this
				if(ItemTypes[i].ItemModelPrefab != null and ItemTypes[i].ItemModelPrefab.resource_path == itemPrefab):
					print("Item id:" + str(i) + " Item Name: " + ItemTypes[i].ItemName)
					itemsInInventory += 1
					OnItemDropped.emit(ItemTypes[i])
					return
				
				printerr("Item not found") 

func OnBodyEnteredArea(body: Node2D):
	if(body is InteractableItem):
		body.GainFocus()
		NearbyBodies.append(body)

func OnBodyExitedArea(body: Node2D):
	if(body is InteractableItem and NearbyBodies.has(body)):
		body.LoseFocus()
		NearbyBodies.remove_at(NearbyBodies.find(body))
