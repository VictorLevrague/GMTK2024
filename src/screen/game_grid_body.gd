extends TextureRect

class_name GridBody

var body_data: BodyData
var dragging: bool = false
@onready var tool_tip = preload("res://src/Ui_items/tool_tip.tscn")

func init(_data: BodyData) -> void:
    body_data = _data

func _ready() -> void:
    expand_mode = TextureRect.EXPAND_IGNORE_SIZE
    stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
    texture = body_data.texture
    
    Signals.mouse_in_slot.connect(mouse_entered_slot)
    Signals.mouse_exited_slot.connect(mouse_exited_slot)
    Signals.drop.connect(body_dropped)
    self.mouse_entered.connect(mouse_entered_body_grid)
    self.mouse_exited.connect(mouse_exited_body_grid)

func mouse_entered_body_grid():
    display_tooltip()

func display_tooltip():
    var tool_tip_instance = tool_tip.instantiate()
    tool_tip_instance.size = Vector2(100,125)
    tool_tip_instance.position = get_local_mouse_position()
    get_tooltip_info(tool_tip_instance)
    self.add_child(tool_tip_instance)

func get_tooltip_info(tool_tip_instance):
    tool_tip_instance.get_node("%Title").text = body_data.name
    var constraint_container = tool_tip_instance.get_node("%ConstraintContainer")
    for constraint in body_data.constraint_array:
        var constraint_display = load("res://src/Ui_items/constraint_hbox.tscn").instantiate()
        constraint_container.add_child(constraint_display)
        constraint_display.get_node("%Description").text = constraint.description
        constraint_display.get_node("%CheckBox").button_pressed = constraint.is_validated

func mouse_exited_body_grid():
    var node_to_remove = get_node("ToolTip")
#    self.remove_child(node_to_remove) 
    node_to_remove.queue_free() #Attention: bug si on fait cette commande et qu'il y a 2 instances de ressources (.tres) identiques en jeu

func mouse_entered_slot(body_slot: PanelContainer):
    if dragging:
        body_slot.theme_type_variation = "HighlightedPanel"


func mouse_exited_slot(panelC: PanelContainer):
    panelC.theme_type_variation = ""

func body_dropped(panelC: PanelContainer):
    dragging = false
    panelC.theme_type_variation = ""

func _get_drag_data(at_position: Vector2):
    dragging = true
    if not body_data.fixed:
        set_drag_preview(make_drag_preview(at_position))
        return self

func make_drag_preview(at_position: Vector2):
    var drag_texture:= TextureRect.new()
    drag_texture.texture = texture
    drag_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
    drag_texture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
    drag_texture.custom_minimum_size = size
    drag_texture.modulate.a = 0.5 #Transparency
    drag_texture.position = Vector2(-at_position)

    var drag_control_node := Control.new()
    drag_control_node.add_child(drag_texture)
    return drag_control_node
