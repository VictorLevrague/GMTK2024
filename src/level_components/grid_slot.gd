@tool

extends Panel

class_name GridSlot

@export var body_data: BodyData = null:
    set(value):
        body_data = value if value != null else null
        %TextureBody.texture = value.texture if value != null else null

@export var is_fixed: bool = false:
    set(value):
        is_fixed = value
        %Lock.visible = value 

@export var orientation_vector:= Vector2(0, -1): #orientation up
    set(value):
        orientation_vector = value
        %TextureBody.rotation = atan2(orientation_vector.x,-orientation_vector.y)
    get:
        return orientation_vector

func _ready():
    self.theme_type_variation = "BasePanel"
    if not Engine.is_editor_hint():
        body_data = body_data.duplicate() if body_data != null else null

func _get_drag_data(at_position: Vector2):
    if self.body_data == null:
        return
    if self.is_fixed:
        return
    Input.set_custom_mouse_cursor(load("res://assets/mouse_click.png"), Input.CURSOR_CAN_DROP)
    Input.set_custom_mouse_cursor(load("res://assets/mouse_click.png"), Input.CURSOR_FORBIDDEN)
    set_drag_preview(make_drag_preview(at_position))
    return self #slot

func make_drag_preview(at_position: Vector2):
    var drag_texture:= TextureRect.new()
    drag_texture.texture = %TextureBody.texture
    drag_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
    drag_texture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
    drag_texture.custom_minimum_size = size
    drag_texture.modulate.a = 0.5 #Transparency
    drag_texture.position = Vector2(-at_position)
    var drag_control_node := Control.new()
    drag_control_node.add_child(drag_texture)
    return drag_control_node
    
func _can_drop_data(at_position: Vector2, data: Variant) -> bool: #data = là où on on a drag
    if self.is_fixed:
        self.theme_type_variation = "ForbiddenPanel"
        return false
    self.theme_type_variation = "HighlightedPanel"
    return true
    
func _drop_data(at_position: Vector2, data: Variant) -> void: #data = là où on on a drag
    swap_bodies(self, data)
    self.theme_type_variation = "BasePanel"
    Signals.emit_signal("drop")
    AudioManager.get_node("BodyDropSuccess").play()
    Tooltip.body_popup(Rect2i(Vector2i(global_position), Vector2i(size)), body_data)
    
func swap_bodies(drag_slot: GridSlot, drop_slot: GridSlot):
    var previous_body_data = drag_slot.body_data
    var previous_orientation:= drag_slot.orientation_vector
    #
    drag_slot.body_data = drop_slot.body_data
    drag_slot.orientation_vector = drop_slot.orientation_vector
    drop_slot.body_data = previous_body_data
    drop_slot.orientation_vector = previous_orientation
    
func _on_mouse_entered():
    if body_data != null:
        Tooltip.body_popup(Rect2i(Vector2i(global_position), Vector2i(size)), body_data)

func _on_mouse_exited():
    self.theme_type_variation = "BasePanel"
    Tooltip.hide_body_popup()

func _notification(what: int) -> void:
  if what == NOTIFICATION_DRAG_END and not get_viewport().gui_is_drag_successful():
    self.theme_type_variation = "BasePanel"
    AudioManager.get_node("BodyDropFail").play()
