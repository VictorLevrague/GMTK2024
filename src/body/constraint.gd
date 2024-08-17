extends Resource

class_name Constraint

var is_validated: bool = false
var description: String = "default"
var logic: Callable

func init(_is_validated:bool, _description: String, _logic:Callable):
    is_validated = _is_validated
    description = _description
    logic = _logic
