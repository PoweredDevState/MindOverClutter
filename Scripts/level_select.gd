extends Control

@export var menuFilePath : String
@export var menuScene : PackedScene
@onready var boxContainerRef := $ScrollContainer/BoxContainer
@export var levelButtonScene : PackedScene

var levelButtons : Array[Dictionary]

func _ready() -> void:
	for num in GameManager.levelScenePaths.size():
		var buttonObj = levelButtonScene.instantiate()
		boxContainerRef.add_child.call_deferred(buttonObj)
		buttonObj.text = "Level " + str(num + 1)
		
		levelButtons.append({num: buttonObj})
		
		levelButtons[num][num].pressed.connect(choose_level.bind(levelButtons[num]))


func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file(menuFilePath)



func choose_level(currentButtonDict : Dictionary) -> void:
	#print(currentButtonDict)
	var levelNumber = Array(currentButtonDict.keys())[0]
	GameManager.start_game_from_level_select(levelNumber)
