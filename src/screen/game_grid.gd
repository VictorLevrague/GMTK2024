extends GridContainer

func _ready() -> void:
    Signals.drop.connect(check_all_body_constraints)
    print("checking")
    check_all_body_constraints(null)

func check_all_body_constraints(_slot: PanelContainer):
    var are_are_constraints_validated:= true
    for grid_slot in get_children():
        if grid_slot.get_child(0) != null: #ça part du principe que les slot sont initialisés à null. Le test if get_child_count() > 0 serait une sécurité en plus
            var body:= grid_slot.get_child(0)
            var grid_slot_size_normalized_in_grid = grid_slot.size + Vector2(self["theme_override_constants/h_separation"],
                                                                     self["theme_override_constants/v_separation"])
            var grid_slot_position_normalized = grid_slot.position / grid_slot_size_normalized_in_grid
            if not body.body_data.check_constraints(body.body_data.constraint_array, self, grid_slot_position_normalized):
                print("failed constraint")
                are_are_constraints_validated = false
    var inventory_grid = get_parent().get_parent().get_node("InventoryGUI/InventoryGrid")
    if inventory_grid.get_child_count()> 0: #Pas ouf, mais disons que ça passe pour aujourd'hui
        var empty_inventory:= true
        for slot in inventory_grid.get_children():
            if slot.get_child_count() > 0:
                empty_inventory = false
        if empty_inventory and are_are_constraints_validated:
            print("All constraints validated !")
            Signals.emit_signal("all_constraints_validated")

    return are_are_constraints_validated

func find_body_in_grid_with_condition(game_grid: GridContainer, coordinates_center_body: Vector2, condition:Callable) ->Array[GridBody]:
    var bodies : Array[GridBody]
    var grid_slots = game_grid.get_children()
    for grid_slot in grid_slots:
        #En théorie, toutes les cases sont censés faire la même taille, donc le calcul suivant est fait plusieurs fois "pour rien"
        var grid_slot_size_normalized_in_grid = grid_slot.size + Vector2(game_grid["theme_override_constants/h_separation"], game_grid["theme_override_constants/v_separation"])
        var grid_slot_position_normalized = grid_slot.position / grid_slot_size_normalized_in_grid
        var abs_diff_to_center_body = abs(coordinates_center_body - grid_slot_position_normalized)
        var max_distance_to_center_body = max(abs_diff_to_center_body.x, abs_diff_to_center_body.y)
        if condition.call(max_distance_to_center_body):
            if grid_slot.get_child_count()>0:
                if grid_slot.get_child(0).body_data.name != "Black Hole":
                    bodies.append(grid_slot.get_child(0))
    return bodies
