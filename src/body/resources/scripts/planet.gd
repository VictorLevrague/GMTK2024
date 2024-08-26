extends BodyData

var constraint1 = Constraint.new()
var constraint1_description := "No neighboring\n planets"

func _init():
    constraint1.init(false, constraint1_description, has_no_neighbour_planet)
    constraint_array = [constraint1]

func find_direct_neighbour(game_grid: GridContainer, coordinates_center_body: Vector2) ->Array:
    var neighbours_temp : Array
    var grid_slots = game_grid.get_children()
    for grid_slot in grid_slots:
        #En théorie, toutes les cases sont censés faire la même taille, donc le calcul suivant est fait à chaque fois "pour rien"
        var grid_slot_size_normalized_in_grid = grid_slot.size + Vector2(game_grid["theme_override_constants/h_separation"], game_grid["theme_override_constants/v_separation"])
        var grid_slot_position_normalized = grid_slot.position / grid_slot_size_normalized_in_grid
        var abs_diff_to_center_body = abs(coordinates_center_body - grid_slot_position_normalized)
        var max_distance_x_y = max(abs_diff_to_center_body.x, abs_diff_to_center_body.y)
        if max_distance_x_y == 1:
            if grid_slot.get_child_count()>0:
                if grid_slot.get_child(0).body_data.name != "Black Hole":
                    neighbours_temp.append(grid_slot.get_child(0))
    return neighbours_temp

func has_no_neighbour_planet(game_grid: GridContainer, coordinates: Vector2) -> bool:
    var has_planet_around: bool = false
    var neighbours:Array = find_direct_neighbour(game_grid, coordinates)
    for neighbour in neighbours:
        if neighbour.body_data.is_planet:
            has_planet_around = true
    return not has_planet_around
