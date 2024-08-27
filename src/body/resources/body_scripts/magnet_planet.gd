extends Planet

var constraint2 = Constraint.new()
var constraint2_description := "Body in front box"

func _init():
    planet_init()
    constraint2.init(false, constraint2_description, has_body_in_front_box)
    constraint_array.append(constraint2)

func find_body_in_front_box(game_grid: GridContainer, coordinates_center_body: Vector2, direction: Vector2) ->Array[GridBody]:
    var bodies_in_front_line : Array[GridBody]
    var grid_slots = game_grid.get_children()
    for grid_slot in grid_slots:
        var grid_slot_size_normalized_in_grid = grid_slot.size + Vector2(game_grid["theme_override_constants/h_separation"], game_grid["theme_override_constants/v_separation"])
        var grid_slot_position_normalized = grid_slot.position / grid_slot_size_normalized_in_grid
        var vector_center_body_to_grid_slot = grid_slot_position_normalized - coordinates_center_body
        if vector_center_body_to_grid_slot == direction:
            if grid_slot.get_child_count()>0:
                if grid_slot.get_child(0).body_data.name != "Black Hole":
                    bodies_in_front_line.append(grid_slot.get_child(0))
    return bodies_in_front_line

func has_body_in_front_box(game_grid: GridContainer, coordinates: Vector2) -> bool:
#Pourrait être mieux 
    var has_body_in_front_box: bool = false
    var neighbours:Array[GridBody] = find_body_in_front_box(game_grid, coordinates, orientation_vector)
    if neighbours.size() > 0:
        has_body_in_front_box = true
    return has_body_in_front_box

