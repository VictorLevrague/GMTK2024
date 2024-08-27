extends BodyData

var constraint1 = Constraint.new()
var constraint1_description := "Has Earth at\n exactly 2 boxes"
var constraint2 = Constraint.new()
var constraint2_description := "Has no Sun or Mini-sun\n neighbor"
var constraint3 = Constraint.new()
var constraint3_description := "Has no UFO\n neighbor"
var constraint4 = Constraint.new()
var constraint4_description := "Has no Star Dust\n neighbor"

func _init():
    constraint1.init(false, constraint1_description, has_earth_at_2_boxes)
    constraint2.init(false, constraint2_description, has_no_sun_or_mini_sun_neighbor)
    constraint3.init(false, constraint3_description, has_no_ufo_neighbor)
    constraint4.init(false, constraint4_description, has_no_stardust_neighbor)
    constraint_array.append_array([constraint1, constraint2, constraint3, constraint4])

func has_no_sun_or_mini_sun_neighbor(game_grid: GridContainer, coordinates_center_body: Vector2) -> bool:
    var has_sun_around: bool = false
    var neighbours:Array[GridBody] = game_grid.find_body_in_grid_with_condition(game_grid, coordinates_center_body, func distance_equal_one(x): return x == 1)
    for neighbour in neighbours:
        if neighbour.body_data.name == "Sun" or neighbour.body_data.name == "Mini Sun":
            has_sun_around = true
    return not has_sun_around

func has_no_ufo_neighbor(game_grid: GridContainer, coordinates_center_body: Vector2) -> bool:
    var has_ufo_around: bool = false
    var neighbours:Array[GridBody] = game_grid.find_body_in_grid_with_condition(game_grid, coordinates_center_body, func distance_equal_one(x): return x == 1)
    for neighbour in neighbours:
        if neighbour.body_data.name == "UFO":
            has_ufo_around = true
    return not has_ufo_around

func has_no_stardust_neighbor(game_grid: GridContainer, coordinates_center_body: Vector2) -> bool:
    var has_stardust_around: bool = false
    var neighbours:Array[GridBody] = game_grid.find_body_in_grid_with_condition(game_grid, coordinates_center_body, func distance_equal_one(x): return x == 1)
    for neighbour in neighbours:
        if neighbour.body_data.name == "Star Dust":
            has_stardust_around = true
    return not has_stardust_around
    
func has_earth_at_2_boxes(game_grid: GridContainer, coordinates_center_body: Vector2) -> bool:
    var is_earth_found: bool = false
    var neighbours:Array[GridBody] = game_grid.find_body_in_grid_with_condition(game_grid, coordinates_center_body, func distance_equal_one(x): return x == 2)
    for neighbour in neighbours:
        if neighbour.body_data.name == "Earth":
            is_earth_found = true
    return is_earth_found
