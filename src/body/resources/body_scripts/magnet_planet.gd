extends Planet

var constraint2 = Constraint.new()
var constraint2_description := "Body in front box"

func _init():
    planet_init()
    constraint2.init(false, constraint2_description, has_body_in_front_box)
    constraint_array.append(constraint2)

func find_body_in_front_box(game_grid: GridContainer, coordinates_center_body: Vector2, direction: Vector2) ->Array[GridSlot]:
    var bodies_in_front_line : Array[GridSlot]
    var grid_slots = game_grid.get_children()
    for grid_slot in grid_slots:
        var grid_slot_size_normalized_in_grid = grid_slot.size + Vector2(game_grid["theme_override_constants/h_separation"], game_grid["theme_override_constants/v_separation"])
        var grid_slot_position_normalized = grid_slot.position / grid_slot_size_normalized_in_grid
        var vector_center_body_to_grid_slot = grid_slot_position_normalized - coordinates_center_body
        if vector_center_body_to_grid_slot == direction:
            if grid_slot.body_data != null:
                if grid_slot.body_data.is_body:
                    bodies_in_front_line.append(grid_slot)
    return bodies_in_front_line

func has_body_in_front_box(game_grid: GridContainer, coordinates: Vector2, _orientation_in_slot: Vector2) -> bool:
#Pourrait être mieux 
    var has_body_in_front_box: bool = false
    var orientation = Vector2(0, 0)
    var neighbours:Array[GridSlot] = find_body_in_front_box(game_grid, coordinates, orientation)
    if neighbours.size() > 0:
        has_body_in_front_box = true
    return has_body_in_front_box

