extends Planet

var constraint2 = Constraint.new()
var constraint2_description := "No neighboring\n bodies"

func _init():
#    planet_init() #No need for planet constraint because self constraint includes it
    constraint2.init(false, constraint2_description, has_no_neighbour_body)
    constraint_array.append(constraint2)

func has_no_neighbour_body(game_grid: GridContainer, coordinates_center_body: Vector2) -> bool:
    var has_body_around: bool = false
    var neighbours:Array[GridBody] = game_grid.find_body_in_grid_with_condition(game_grid, coordinates_center_body, func distance_equal_one(x): return x == 1)
    for neighbour in neighbours:
        if neighbour != null:
            has_body_around = true
    return not has_body_around
