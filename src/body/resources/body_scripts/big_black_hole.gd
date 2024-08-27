extends BodyData

var constraint1 = Constraint.new()
var constraint1_description := "Has \n8 neighbor bodies"

func _init():
    constraint1.init(false, constraint1_description, has_8_neighbors)
    constraint_array = [constraint1]

func has_8_neighbors(game_grid: GridContainer, coordinates_center_body: Vector2) -> bool:
    var neighbours:Array[GridBody] = game_grid.find_body_in_grid_with_condition(game_grid, coordinates_center_body, func distance_equal_one(x): return x == 1)
    return (neighbours.size() == 8)
