extends BodyData

class_name Planet

var constraint1 = Constraint.new()
var constraint1_description := "No neighboring\n planets"

func _init():
    planet_init()

func planet_init():
    constraint1.init(false, constraint1_description, has_no_neighbour_planet)
    constraint_array.append(constraint1)
    print("in planet init")

func has_no_neighbour_planet(game_grid: GridContainer, coordinates_center_body: Vector2) -> bool:
    var has_planet_around: bool = false
    var neighbours:Array = game_grid.find_body_in_grid_with_condition(game_grid, coordinates_center_body, func distance_equal_one(x): return x == 1)
    for neighbour in neighbours:
        if neighbour.body_data is Planet:
            has_planet_around = true
    return not has_planet_around
