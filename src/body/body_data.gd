extends Resource

class_name BodyData

@export var name: String
@export var texture: Texture
@export var description: String
@export var is_body: bool = true
var constraint_array = []

#set(value):
    #orientation_vector = value
    #texture.rotation = (PI/2) * (orientation_vector.y + (1 - orientation_vector.x))
    #print(texture.rotation)

func check_constraints(constraint_array: Array, game_grid: GridContainer, coordinates: Vector2,
                         orientation_in_slot: Vector2) -> bool:
    var all_constraints_validated:= true
    for constraint in constraint_array:
        if not constraint.logic.call(game_grid, coordinates, orientation_in_slot):
            constraint.is_validated = false
            all_constraints_validated = false
        else:
            constraint.is_validated = true
    for constraint in constraint_array:
        print(constraint.description, " is: ", constraint.is_validated)
    return all_constraints_validated
