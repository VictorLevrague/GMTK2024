extends Node

@export var next_level:PackedScene
@export var music_level:AudioStreamMP3

func _ready() -> void:
    play_music()
    Signals.drop.connect(validate_level)
    Signals.level_complete.connect(show_victory_screen)
    Signals.next_level_signal.connect(change_to_next_level)
    %GameGrid.call_deferred("check_all_body_constraints") #call_deferred nécessaire pour retarder l'appel de cette fonction. La position d'un objet dans un container n'est pas actualisée dès le début, il faut attendre la fin de la frame. Et ces positions sont nécessaires pour le calcul des contraintes.
    
func validate_level():
    if  %GameGrid.check_all_body_constraints() and is_inventory_grid_empty():
        Signals.emit_signal("level_complete")

func is_inventory_grid_empty():
    var empty_inventory:= true
    for slot in %InventoryGrid.get_children():
        if slot is GridSlot and slot.body_data != null:
            empty_inventory = false
    return empty_inventory

func show_victory_screen():
    AudioManager.get_node("ValidationSuccess").play()
    get_tree().paused = true
    %Level_UI/WinningLevelScreen.show()

func change_to_next_level():
    get_tree().change_scene_to_packed(next_level)

func play_music():
    var is_same_music:bool = AudioManager.get_node("Music").stream == music_level
    if not music_level == null:
        if not (AudioManager.get_node("Music").stream == music_level): #pour ne pas que la musique se relance si c'est la même que sur l'écran principal ou niveau précédent
            AudioManager.get_node("Music").stream = music_level
            AudioManager.get_node("Music").play()
