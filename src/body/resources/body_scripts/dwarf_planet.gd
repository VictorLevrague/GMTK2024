extends BodyData

var constraint1 = Constraint.new()
var constraint1_description := "Has exactly\n2 neighbor planets"

func _init():
    constraint1.init(false, constraint1_description, has_2_planet_neighbor)
    constraint_array = [constraint1]

func has_2_planet_neighbor(game_grid: GridContainer, coordinates_center_body: Vector2) -> bool:
    var has_ufo_around: bool = false
    var neighbours:Array = game_grid.find_body_in_grid_with_condition(game_grid, coordinates_center_body, func distance_equal_one(x): return x == 1)
    var planet_count = 0
    for neighbour in neighbours:
        if neighbour.body_data.is_planet:
            planet_count += 1
    return (planet_count == 2)
