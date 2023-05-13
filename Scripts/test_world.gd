extends Node2D

@onready var artifact_container = $ArtifactContainer
@onready var artifact1 = $Artifacts/bunny_hoppers
@onready var artifact2 = $Artifacts/fire_gauntlet
@onready var artifact3 = $Artifacts/crystal_heart

func _ready():
	print(artifact1) # Отладочная информация
	print(artifact2) # Отладочная информация
	print(artifact3) # Отладочная информация
	var artifacts = [artifact1, artifact2, artifact3]
	var artifact = artifacts[randi() % artifacts.size()]
	print(artifact) # Отладочная информация
	artifact = artifact.duplicate()
	artifact_container.add_child(artifact)
