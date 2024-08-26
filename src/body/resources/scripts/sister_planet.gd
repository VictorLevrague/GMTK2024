extends Planet

var constraint1_bis = Constraint.new()
var constraint1_bis_description := "No neighboring\n planets\n (except sister)"

var constraint2 = Constraint.new()
var constraint2_description := "Has Sister\n Planet neighbor"

func _init():
#    planet_init() no need to initialize planet constraint because the behavior has to be changed here to exclude sister planet
    constraint1_bis.init(false, constraint1_bis_description, has_no_neighbour_planet_except_sister)
    constraint2.init(false, constraint2_description, has_a_sister_neighbor)
    constraint_array.append_array([constraint1_bis, constraint2])

func has_no_neighbour_planet_except_sister(game_grid: GridContainer, coordinates_center_body: Vector2) -> bool:
    var has_planet_around: bool = false
    var neighbours:Array = game_grid.find_body_in_grid_with_condition(game_grid, coordinates_center_body, func distance_equal_one(x): return x == 1)
    for neighbour in neighbours:
        if neighbour.body_data.is_planet and neighbour.body_data.name != "Sister Planet":
            has_planet_around = true
    return not has_planet_around

func has_a_sister_neighbor(game_grid: GridContainer, coordinates_center_body: Vector2) -> bool:
    var has_sister_around: bool = false
    var neighbours:Array = game_grid.find_body_in_grid_with_condition(game_grid, coordinates_center_body, func distance_equal_one(x): return x == 1)
    for neighbour in neighbours:
        if neighbour.body_data.name == "Sister Planet":
            has_sister_around = true
    return has_sister_around
