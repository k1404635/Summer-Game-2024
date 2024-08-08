extends Node2D
class_name InteractableItem

@export var ItemHighlightMesh : MeshInstance2D

#dont really need a highlight mesh for my game
func GainFocus():
	ItemHighlightMesh.visible = true
	
func LoseFocus():
	ItemHighlightMesh.visible = false
