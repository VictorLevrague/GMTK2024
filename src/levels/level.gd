extends Node

@export var next_level:PackedScene

func _ready() -> void:
    Signals.drop.connect(check_all_body_constraints)
    Signals.all_constraints_validated.connect(show_victory_screen)
    Signals.next_level_signal.connect(change_to_next_level)
    call_deferred("check_all_body_constraints") #call_deferred nécessaire pour retarder l'appel de cette fonction. La position d'un objet dans un container n'est pas actualisée dès le début, il faut attendre la fin de la frame. Et ces positions sont nécessaires pour le calcul des contraintes.

func check_all_body_constraints():
    var are_are_constraints_validated:= true
    for grid_slot in %GameGrid.get_children():
        if grid_slot.body_data != null:
            var slot_data:BodyData = grid_slot.body_data
            var grid_slot_size_normalized_in_grid = grid_slot.size + Vector2(%GameGrid["theme_override_constants/h_separation"],
                                                                     %GameGrid["theme_override_constants/v_separation"])
            var grid_slot_position_normalized = grid_slot.position / grid_slot_size_normalized_in_grid
            if not slot_data.check_constraints(slot_data.constraint_array, %GameGrid, grid_slot_position_normalized):
                print("failed constraint")
                are_are_constraints_validated = false
    if is_inventory_grid_empty() and are_are_constraints_validated:
        print("All constraints validated !")
        Signals.emit_signal("all_constraints_validated")
    return are_are_constraints_validated

func is_inventory_grid_empty():
    var empty_inventory:= true
    for slot in %InventoryGrid.get_children():
        if slot.body_data != null:
            empty_inventory = false
    return empty_inventory

func show_victory_screen():
    #get_tree().root.get_child(1).get_node("ValidationSuccess").play()
    %Level_UI/WinningLevelScreen.show()

func change_to_next_level():
    get_tree().change_scene_to_packed(next_level)
