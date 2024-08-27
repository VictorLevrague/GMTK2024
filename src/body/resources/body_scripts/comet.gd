extends BodyData

var constraint1 = Constraint.new()
var constraint1_description := "No Body in front line"

func _init():
    constraint1.init(false, constraint1_description, has_no_body_in_front_line)
    constraint_array.append(constraint1)

func find_body_in_direction(game_grid: GridContainer, coordinates_center_body: Vector2, direction: Vector2) ->Array[GridBody]:
    var bodies_in_front_line : Array[GridBody]
    var grid_slots = game_grid.get_children()
    for grid_slot in grid_slots:
        var grid_slot_size_normalized_in_grid = grid_slot.size + Vector2(game_grid["theme_override_constants/h_separation"], game_grid["theme_override_constants/v_separation"])
        var grid_slot_position_normalized = grid_slot.position / grid_slot_size_normalized_in_grid
        var vector_center_body_to_grid_slot = grid_slot_position_normalized - coordinates_center_body
        if vector_center_body_to_grid_slot * direction > Vector2(0,0) and vector_center_body_to_grid_slot.cross(direction) == 0: #Test pour bonne direction (même signe entre vecteur direction et vecteur case ref vers case autre), et bonne ligne (vecteur parallèle au vecteur direction)
            if grid_slot.get_child_count()>0:
                if grid_slot.get_child(0).body_data.name != "Black Hole":
                    bodies_in_front_line.append(grid_slot.get_child(0))
    return bodies_in_front_line
    
func has_no_body_in_front_line(game_grid: GridContainer, coordinates_center_body: Vector2) -> bool:
    var has_body_in_direction: bool = false
    var neighbours:Array[GridBody] = find_body_in_direction(game_grid, coordinates_center_body, orientation_vector)
    if neighbours.size() > 0:
        has_body_in_direction = true
    return not has_body_in_direction
