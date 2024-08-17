extends TextureRect

class_name GridBody

var body_data: BodyData
var dragging: bool = false

func init(_data: BodyData) -> void:
    body_data = _data

func _ready() -> void:
    expand_mode = TextureRect.EXPAND_IGNORE_SIZE
    stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
    texture = body_data.texture
    tooltip_text = "%s\n%s" % [body_data.name, body_data.name]
    
    Signals.mouse_in_slot.connect(mouse_entered_slot)
    Signals.mouse_exited_slot.connect(mouse_exited_slot)
    Signals.drop.connect(body_dropped)

func mouse_entered_slot(panelC: PanelContainer):
     if dragging:
        panelC.theme_type_variation = "HighlightedPanel"

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
