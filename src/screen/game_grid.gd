extends GridContainer

#func _ready() -> void:
    #Signals.drop.connect(check_all_body_constraints)
    ##check_all_body_constraints()
    #call_deferred("check_all_body_constraints") #call_deferred nécessaire pour retarder l'appel de cette fonction. La position d'un objet dans un container n'est pas actualisée dès le début, il faut attendre la fin de la frame. Et ces positions sont nécessaires pour le calcul des contraintes.
#
#func check_all_body_constraints():
    #var are_are_constraints_validated:= true
    #for grid_slot in get_children():
        #if grid_slot.body_data != null:
            #var slot_data:BodyData = grid_slot.body_data
            #var grid_slot_size_normalized_in_grid = grid_slot.size + Vector2(self["theme_override_constants/h_separation"],
                                                                     #self["theme_override_constants/v_separation"])
            #var grid_slot_position_normalized = grid_slot.position / grid_slot_size_normalized_in_grid
            #if not slot_data.check_constraints(slot_data.constraint_array, self, grid_slot_position_normalized):
                #print("failed constraint")
                #are_are_constraints_validated = false
    ##var inventory_grid = %InventoryGrid #A refactor
    ##if inventory_grid.get_child_count()> 0: #Pas ouf, mais disons que ça passe pour aujourd'hui
        ##var empty_inventory:= true
        ##for slot in inventory_grid.get_children():
            ##if slot.get_child_count() > 0:
                ##empty_inventory = false
        ##if empty_inventory and are_are_constraints_validated:
            ##print("All constraints validated !")
            ##Signals.emit_signal("all_constraints_validated")
    #return are_are_constraints_validated

func find_body_in_grid_with_condition(game_grid: GridContainer, coordinates_center_body: Vector2, condition:Callable) ->Array[GridSlot]:
    var slots_within_condition : Array[GridSlot]
    var grid_slots: Array = game_grid.get_children()
    for grid_slot in grid_slots:
        #En théorie, toutes les cases sont censés faire la même taille, donc le calcul suivant est fait plusieurs fois "pour rien"
        var grid_slot_size_normalized_in_grid = grid_slot.size + Vector2(game_grid["theme_override_constants/h_separation"], game_grid["theme_override_constants/v_separation"])
        var grid_slot_position_normalized = grid_slot.position / grid_slot_size_normalized_in_grid
        var abs_diff_to_center_body = abs(coordinates_center_body - grid_slot_position_normalized)
        var max_distance_to_center_body = max(abs_diff_to_center_body.x, abs_diff_to_center_body.y)
        if condition.call(max_distance_to_center_body):
            if grid_slot.body_data != null:
                if grid_slot.body_data.name != "Black Hole":
                    slots_within_condition.append(grid_slot)
    return slots_within_condition

#func show_victory_screen():
    ##get_tree().root.get_child(1).get_node("ValidationSuccess").play()
    #%WinningLevelScreen.show()
