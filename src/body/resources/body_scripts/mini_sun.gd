extends BodyData

var constraint1 = Constraint.new()
var constraint1_description := "Has Sun\n neighbor"

func _init():
    constraint1.init(false, constraint1_description, has_a_sun_neighbor)
    constraint_array = [constraint1]

func has_a_sun_neighbor(game_grid: GridContainer, coordinates_center_body: Vector2) -> bool:
    var has_sun_around: bool = false
    var neighbours:Array[GridBody] = game_grid.find_body_in_grid_with_condition(game_grid, coordinates_center_body, func distance_equal_one(x): return x == 1)
    for neighbour in neighbours:
        if neighbour.body_data.name == "Sun":
            has_sun_around = true
    return has_sun_around
