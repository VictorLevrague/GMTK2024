extends Resource

class_name BodyData

@export var name: String
@export var fixed: bool = true
@export var is_planet: bool = false
@export var texture: Texture
@export var orientation_vector: Vector2

func check_constraints(constraint_array: Array, game_grid: GridContainer, coordinates: Vector2) -> bool:
    var all_constraints_validated:= true
    for constraint in constraint_array:
        if not constraint.logic.call(game_grid, coordinates):
            constraint.is_validated = false
            all_constraints_validated = false
        else:
            constraint.is_validated = true
    for constraint in constraint_array:
        print(constraint.description, " is: ", constraint.is_validated)
    return all_constraints_validated
