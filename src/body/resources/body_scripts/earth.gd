extends Planet

var constraint2 = Constraint.new()
var constraint2_description := "Has sun at\n exactly 3 boxes"

var constraint3 = Constraint.new()
var constraint3_description := "No sun\nunder 2 boxes"

func _init():
    planet_init()
    constraint2.init(false, constraint2_description, has_sun_at_3_boxes)
    constraint3.init(false, constraint3_description, has_no_sun_below_2_boxes)
    constraint_array.append_array([constraint2])

func has_sun_at_3_boxes(game_grid: GridContainer, coordinates_center_body: Vector2) -> bool:
    var is_sun_found: bool = false
    var neighbours:Array[GridBody] = game_grid.find_body_in_grid_with_condition(game_grid, coordinates_center_body, func distance_equal_one(x): return x == 3)
    for neighbour in neighbours:
        if neighbour.body_data.name == "Sun":
            is_sun_found = true
    return is_sun_found

func has_no_sun_below_2_boxes(game_grid: GridContainer, coordinates_center_body: Vector2):
    var has_no_sun: bool = true
    var neighbours:Array[GridBody] = game_grid.find_body_in_grid_with_condition(game_grid, coordinates_center_body, func distance_equal_one(x): return x <= 2)
    for neighbour in neighbours:
        if neighbour.body_data.name == "Sun":
            has_no_sun = false
    return has_no_sun
