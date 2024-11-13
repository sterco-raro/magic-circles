class_name CircleUISection extends Control


#region SIGNALS
# Section toggle
signal section_toggle_bottom(toggled_on: bool)
signal section_toggle_top(toggled_on: bool)

# Radius
signal radius_slider_bottom(value: float)
signal radius_slider_top(value: float)

# Line color
signal line_color_bottom(color: Color)
signal line_color_top(color: Color)

# Double line toggle
signal double_line_toggle_bottom(toggled_on: bool)
signal double_line_toggle_top(toggled_on: bool)

# Double line spacing
signal double_line_spacing_bottom(value: float)
signal double_line_spacing_top(value: float)

# Rings toggle
signal rings_toggle_bottom(toggled_on: bool)
signal rings_toggle_top(toggled_on: bool)

# Rings number
signal rings_number_bottom(value: float)
signal rings_number_top(value: float)

# Rings radius
signal rings_radius_bottom(value: float)
signal rings_radius_top(value: float)

# Rings offset
signal rings_offset_bottom(value: float)
signal rings_offset_top(value: float)
#endregion


#region EXPORTS
@export
var SECTION_TITLE: String

@export_group("Controls setup")

@export_subgroup("Circle")
@export
var RADIUS_MIN: float
@export
var RADIUS_MAX: float
@export
var SPACING_MIN: float
@export
var SPACING_MAX: float

@export_subgroup("Rings")
@export
var RINGS_NUMBER_MAX: float
@export
var RINGS_RADIUS_MIN: float
@export
var RINGS_RADIUS_MAX: float
#endregion


func _ready() -> void:
	$SectionHeader/Label.text = SECTION_TITLE
	%RadiusSlider.min_value = RADIUS_MIN
	%RadiusSlider.max_value = RADIUS_MAX
	%DoubleLineSpacingSlider.min_value = SPACING_MIN
	%DoubleLineSpacingSlider.max_value = SPACING_MAX
	%RingsNumberSlider.min_value = 1
	%RingsNumberSlider.max_value = RINGS_NUMBER_MAX
	%RingsRadiusSlider.min_value = RINGS_RADIUS_MIN
	%RingsRadiusSlider.max_value = RINGS_RADIUS_MAX
	%RingsOffsetSlider.min_value = 0
	%RingsOffsetSlider.max_value = 360


#region CUSTOM FUNCTIONS
# Section toggle
func update_section_visibility(visibility: bool) -> void:
	$SectionBody.visible = visibility

# Double line toggle
func update_double_line_section_visibility(visibility: bool) -> void:
	$SectionBody/VBoxContainer/DoubleLineSpacing.visible = visibility

# Rings toggle
func update_rings_section_visibility(visibility: bool) -> void:
	$SectionBody/VBoxContainer/Rings/Body.visible = visibility
#endregion


#region SIGNAL HANDLERS
# Section toggle
func _on_section_toggle_toggled(toggled_on: bool) -> void:
	section_toggle_bottom.emit(toggled_on)
	update_section_visibility(toggled_on)
func _on_section_toggle_top(toggled_on: bool) -> void:
	%SectionToggle.button_pressed = toggled_on
	update_section_visibility(toggled_on)

# Radius
func _on_radius_slider_value_changed(value: float) -> void:
	radius_slider_bottom.emit(value)
func _on_radius_slider_top(value: float) -> void:
	%RadiusSlider.value = value

# Line color
func _on_line_color_button_color_changed(color: Color) -> void:
	line_color_bottom.emit(color)
func _on_line_color_top(color: Color) -> void:
	%LineColorButton.color = color

# Double line toggle
func _on_double_line_toggle_toggled(toggled_on: bool) -> void:
	double_line_toggle_bottom.emit(toggled_on)
	update_double_line_section_visibility(toggled_on)
func _on_double_line_toggle_top(toggled_on: bool) -> void:
	%DoubleLineToggle.button_pressed = toggled_on
	update_double_line_section_visibility(toggled_on)

# Double line spacing
func _on_double_line_spacing_slider_value_changed(value: float) -> void:
	double_line_spacing_bottom.emit(value)
func _on_double_line_spacing_top(value: float) -> void:
	%DoubleLineSpacingSlider.value = value

# Rings toggle
func _on_rings_toggle_toggled(toggled_on: bool) -> void:
	rings_toggle_bottom.emit(toggled_on)
	update_rings_section_visibility(toggled_on)
func _on_rings_toggle_top(toggled_on: bool) -> void:
	%RingsToggle.button_pressed = toggled_on
	update_rings_section_visibility(toggled_on)

# Rings number
func _on_rings_number_slider_value_changed(value: float) -> void:
	rings_number_bottom.emit(value)
func _on_rings_number_top(value: float) -> void:
	%RingsNumberSlider.value = value

# Rings radius
func _on_rings_radius_slider_value_changed(value: float) -> void:
	rings_radius_bottom.emit(value)
func _on_rings_radius_top(value: float) -> void:
	%RingsRadiusSlider.value = value

# Rings offset
func _on_rings_offset_slider_value_changed(value: float) -> void:
	rings_offset_bottom.emit(value)
func _on_rings_offset_top(value: float) -> void:
	%RingsOffsetSlider.value = value
#endregion
