extends GridContainer

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
                if grid_slot.body_data.is_body:
                    slots_within_condition.append(grid_slot)
    return slots_within_condition
