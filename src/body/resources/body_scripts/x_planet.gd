extends Planet

var constraint1_bis = Constraint.new()
var constraint1_bis_description := "No neighboring\n planets\n (except X)"

var constraint2 = Constraint.new()
var constraint2_description := "Has X\n Planets in diagonal"

func _init():
#    planet_init() no need to initialize planet constraint because the behavior has to be changed here to exclude x planet
    constraint1_bis.init(false, constraint1_bis_description, has_no_neighbour_planet_except_x)
    constraint2.init(false, constraint2_description, has_a_x_diagonal)
    constraint_array.append_array([constraint1_bis, constraint2])

func has_no_neighbour_planet_except_x(game_grid: GridContainer, coordinates_center_body: Vector2, _orientation_in_slot: Vector2) -> bool:
    var has_planet_around: bool = false
    var neighbours:Array[GridSlot] = game_grid.find_body_in_grid_with_condition(game_grid, coordinates_center_body, func distance_equal_one(x): return x == 1)
    for neighbour in neighbours:
        if neighbour.body_data is Planet and neighbour.body_data.name != "X Planets":
            has_planet_around = true
    return not has_planet_around

func has_a_x_diagonal(game_grid: GridContainer, coordinates_center_body: Vector2, _orientation_in_slot: Vector2) -> bool:
    var has_x_diagonal: bool = false
    var neighbours:Array[GridSlot] = find_body_in_diagonal(game_grid, coordinates_center_body)
    for neighbour in neighbours:
        if neighbour.body_data.name == "X Planets":
            has_x_diagonal = true
    return has_x_diagonal

func find_body_in_diagonal(game_grid: GridContainer, coordinates_center_body: Vector2) ->Array[GridSlot]:
    var slots_within_condition : Array[GridSlot]
    var grid_slots: Array = game_grid.get_children()
    for grid_slot in grid_slots:
        var grid_slot_size_normalized_in_grid = grid_slot.size + Vector2(game_grid["theme_override_constants/h_separation"], game_grid["theme_override_constants/v_separation"])
        var grid_slot_position_normalized = grid_slot.position / grid_slot_size_normalized_in_grid
        var abs_diff_to_center_body = abs(coordinates_center_body - grid_slot_position_normalized)
        var max_distance_to_center_body = max(abs_diff_to_center_body.x, abs_diff_to_center_body.y)
        if (max_distance_to_center_body == 1) and (abs_diff_to_center_body.x + abs_diff_to_center_body.y == 2):
            if grid_slot.body_data != null:
                if grid_slot.body_data.is_body:
                    slots_within_condition.append(grid_slot)
    return slots_within_condition
