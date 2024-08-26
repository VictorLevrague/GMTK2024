extends BodyData

var constraint1 = Constraint.new()
var constraint1_description := "Planet as\nunique neighbor"

func _init():
    constraint1.init(false, constraint1_description, has_unique_neighbor_planet)
    constraint_array.append(constraint1)

func has_unique_neighbor_planet(game_grid: GridContainer, coordinates_center_body: Vector2) -> bool:
    var has_unique_planet_around: bool = false
    var neighbours:Array = game_grid.find_body_in_grid_with_condition(game_grid, coordinates_center_body, func distance_equal_one(x): return x == 1)
    if neighbours.size() == 1:
        for neighbour in neighbours:
            if neighbour.body_data.is_planet:
                has_unique_planet_around = true
    return has_unique_planet_around
