extends Area2D

signal OnItemPickedUp(item)
signal OnItemDropped(item)

@export var ItemTypes : Array[ItemData] = []
@export var CounterTypes : Array[CounterData] = []

var NearbyCounters : Array[InteractableCounters]
var NearbyBodies : Array[InteractableItem]
var InventoryItems : Array[InteractableItem]

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("Pickup or Put down")):
		if InventoryItems.is_empty():
			Pickup()
		else:
			PutDown()
		
func Pickup():
	var nearestItem : InteractableItem = null
	var nearestDistance : float = INF
	for item in NearbyBodies:
		if(item.global_position.distance_to(global_position) < nearestDistance):
			nearestDistance = item.global_position.distance_to(global_position)
			nearestItem = item
			
		
		if nearestItem != null and InventoryItems.is_empty():
			if(!(nearestItem.name == "EggplantSack" or nearestItem.name == "CabbageSack" or nearestItem.name == "MeatSack" or nearestItem.name == "TomatoSack")):
				nearestItem.queue_free()
				NearbyBodies.remove_at(NearbyBodies.find(nearestItem))
			var itemPrefab = nearestItem.scene_file_path
			for i in ItemTypes.size():
				if(ItemTypes[i].ItemModelPrefab != null and ItemTypes[i].ItemModelPrefab.resource_path == itemPrefab):
					print("Item id:" + str(i) + " Item Name: " + ItemTypes[i].ItemName)
					InventoryItems.append(nearestItem)
					OnItemPickedUp.emit(ItemTypes[i])
					return
				
			printerr("Item not found") 

func PutDown(): # FIX THIS METHOD AFTER FIGURING OUT HOW TO DO THE TABLE INTERACTION INSTEAD OF INDIVIDUAL ITEMS
	if(!NearbyCounters.is_empty()): # need to put everything below in this if statement probs??
		pass
		
	#change the item parts to fit the tables instead of items
	var nearestCounter : InteractableCounters = null
	var nearestDistance : float = INF
	for counters in NearbyCounters:
		if(counters.global_position.distance_to(global_position) < nearestDistance):
			nearestDistance = counters.global_position.distance_to(global_position)
			nearestCounter = counters
		
		var ItemName = null
		if nearestCounter != null and InventoryItems.size() == 1:
			nearestCounter.add_child(InventoryItems[0])
			var itemPrefab = InventoryItems[0].scene_file_path
			for i in ItemTypes.size(): 
				if(ItemTypes[i].ItemModelPrefab != null and ItemTypes[i].ItemModelPrefab.resource_path == itemPrefab):
					ItemName = ItemTypes[i].ItemName
					break
			
			# put all the combinations of counter types and available items to place them on that type
			if(ItemName != null):
				if(ItemName != "Cooked Meat" and ItemName != "Salad" and nearestCounter.name != "Table"):
					pass
			

func OnBodyEnteredArea(body: Node2D):
	if(body is InteractableItem):
		NearbyBodies.append(body)
	if(body is InteractableCounters):
		NearbyCounters.append(body)

func OnBodyExitedArea(body: Node2D):
	if(body is InteractableItem and NearbyBodies.has(body)):
		NearbyBodies.remove_at(NearbyBodies.find(body))
	if(body is InteractableCounters and NearbyCounters.has(body)):
		NearbyCounters.remove_at(NearbyCounters.find(body))
