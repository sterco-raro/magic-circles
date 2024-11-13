class_name SettingsPanel extends Control


func _ready() -> void:
	#region CONNECTIONS
	# General
	EventBus.background_color_top.connect(_on_background_color_top)

	# Inner circle
	EventBus.inner_circle_toggle_top.connect(_on_inner_circle_toggle_top)
	EventBus.inner_circle_radius_top.connect(_on_inner_circle_radius_top)
	EventBus.inner_circle_line_color_top.connect(_on_inner_circle_line_color_top)
	EventBus.inner_circle_double_line_toggle_top.connect(_on_inner_circle_double_line_toggle_top)
	EventBus.inner_circle_double_line_spacing_top.connect(_on_inner_circle_double_line_spacing_top)
	EventBus.inner_circle_rings_toggle_top.connect(_on_inner_circle_rings_toggle_top)
	EventBus.inner_circle_rings_number_top.connect(_on_inner_circle_rings_number_top)
	EventBus.inner_circle_rings_radius_top.connect(_on_inner_circle_rings_radius_top)
	EventBus.inner_circle_rings_offset_top.connect(_on_inner_circle_rings_offset_top)

	# Outer circle
	EventBus.outer_circle_toggle_top.connect(_on_outer_circle_toggle_top)
	EventBus.outer_circle_radius_top.connect(_on_outer_circle_radius_top)
	EventBus.outer_circle_line_color_top.connect(_on_outer_circle_line_color_top)
	EventBus.outer_circle_double_line_toggle_top.connect(_on_outer_circle_double_line_toggle_top)
	EventBus.outer_circle_double_line_spacing_top.connect(_on_outer_circle_double_line_spacing_top)
	EventBus.outer_circle_rings_toggle_top.connect(_on_outer_circle_rings_toggle_top)
	EventBus.outer_circle_rings_number_top.connect(_on_outer_circle_rings_number_top)
	EventBus.outer_circle_rings_radius_top.connect(_on_outer_circle_rings_radius_top)
	EventBus.outer_circle_rings_offset_top.connect(_on_outer_circle_rings_offset_top)
	#endregion


#region SIGNAL HANDLERS
# Background color
func _on_background_color_picker_button_color_changed(color: Color) -> void:
	EventBus.background_color_bottom.emit(color)
func _on_background_color_top(color: Color) -> void:
	%BackgroundColorPickerButton.color = color

# Inner circle toggle
func _on_inner_circle_section_toggle_bottom(toggled_on: bool) -> void:
	EventBus.inner_circle_toggle_bottom.emit(toggled_on)
func _on_inner_circle_toggle_top(toggled_on: bool) -> void:
	%InnerCircle.section_toggle_top.emit(toggled_on)

# Inner circle radius
func _on_inner_circle_radius_slider_bottom(value: float) -> void:
	EventBus.inner_circle_radius_bottom.emit(value)
func _on_inner_circle_radius_top(value: float) -> void:
	%InnerCircle.radius_slider_top.emit(value)

# Inner circle line color
func _on_inner_circle_line_color_bottom(color: Color) -> void:
	EventBus.inner_circle_line_color_bottom.emit(color)
func _on_inner_circle_line_color_top(color: Color) -> void:
	%InnerCircle.line_color_top.emit(color)

# Inner circle double line toggle
func _on_inner_circle_double_line_toggle_bottom(toggled_on: bool) -> void:
	EventBus.inner_circle_double_line_toggle_bottom.emit(toggled_on)
func _on_inner_circle_double_line_toggle_top(toggled_on: bool) -> void:
	%InnerCircle.double_line_toggle_top.emit(toggled_on)

# Inner circle double line spacing
func _on_inner_circle_double_line_spacing_bottom(value: float) -> void:
	EventBus.inner_circle_double_line_spacing_bottom.emit(value)
func _on_inner_circle_double_line_spacing_top(value: float) -> void:
	%InnerCircle.double_line_spacing_top.emit(value)

# Inner circle rings toggle
func _on_inner_circle_rings_toggle_bottom(toggled_on: bool) -> void:
	EventBus.inner_circle_rings_toggle_bottom.emit(toggled_on)
func _on_inner_circle_rings_toggle_top(toggled_on: bool) -> void:
	%InnerCircle.rings_toggle_top.emit(toggled_on)

# Inner circle rings number
func _on_inner_circle_rings_number_bottom(value: float) -> void:
	EventBus.inner_circle_rings_number_bottom.emit(value)
func _on_inner_circle_rings_number_top(value: float) -> void:
	%InnerCircle.rings_number_top.emit(value)

# Inner circle rings radius
func _on_inner_circle_rings_radius_bottom(value: float) -> void:
	EventBus.inner_circle_rings_radius_bottom.emit(value)
func _on_inner_circle_rings_radius_top(value: float) -> void:
	%InnerCircle.rings_radius_top.emit(value)

# Inner circle rings offset
func _on_inner_circle_rings_offset_bottom(value: float) -> void:
	EventBus.inner_circle_rings_offset_bottom.emit(value)
func _on_inner_circle_rings_offset_top(value: float) -> void:
	%InnerCircle.rings_offset_top.emit(value)

# Outer circle toggle
func _on_outer_circle_section_toggle_bottom(toggled_on: bool) -> void:
	EventBus.outer_circle_toggle_bottom.emit(toggled_on)
func _on_outer_circle_toggle_top(toggled_on: bool) -> void:
	%OuterCircle.section_toggle_top.emit(toggled_on)

# Outer circle radius
func _on_outer_circle_radius_slider_bottom(value: float) -> void:
	EventBus.outer_circle_radius_bottom.emit(value)
func _on_outer_circle_radius_top(value: float) -> void:
	%OuterCircle.radius_slider_top.emit(value)

# Outer circle line color
func _on_outer_circle_line_color_bottom(color: Color) -> void:
	EventBus.outer_circle_line_color_bottom.emit(color)
func _on_outer_circle_line_color_top(color: Color) -> void:
	%OuterCircle.line_color_top.emit(color)

# Outer circle double line toggle
func _on_outer_circle_double_line_toggle_bottom(toggled_on: bool) -> void:
	EventBus.outer_circle_double_line_toggle_bottom.emit(toggled_on)
func _on_outer_circle_double_line_toggle_top(toggled_on: bool) -> void:
	%OuterCircle.double_line_toggle_top.emit(toggled_on)

# Outer circle double line spacing
func _on_outer_circle_double_line_spacing_bottom(value: float) -> void:
	EventBus.outer_circle_double_line_spacing_bottom.emit(value)
func _on_outer_circle_double_line_spacing_top(value: float) -> void:
	%OuterCircle.double_line_spacing_top.emit(value)

# Outer circle rings toggle
func _on_outer_circle_rings_toggle_bottom(toggled_on: bool) -> void:
	EventBus.outer_circle_rings_toggle_bottom.emit(toggled_on)
func _on_outer_circle_rings_toggle_top(toggled_on: bool) -> void:
	%OuterCircle.rings_toggle_top.emit(toggled_on)

# Outer circle rings number
func _on_outer_circle_rings_number_bottom(value: float) -> void:
	EventBus.outer_circle_rings_number_bottom.emit(value)
func _on_outer_circle_rings_number_top(value: float) -> void:
	%OuterCircle.rings_number_top.emit(value)

# Outer circle rings radius
func _on_outer_circle_rings_radius_bottom(value: float) -> void:
	EventBus.outer_circle_rings_radius_bottom.emit(value)
func _on_outer_circle_rings_radius_top(value: float) -> void:
	%OuterCircle.rings_radius_top.emit(value)

# Outer circle rings offset
func _on_outer_circle_rings_offset_bottom(value: float) -> void:
	EventBus.outer_circle_rings_offset_bottom.emit(value)
func _on_outer_circle_rings_offset_top(value: float) -> void:
	%OuterCircle.rings_offset_top.emit(value)
#endregion
