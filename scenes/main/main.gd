extends Node2D

#region ONREADY PROPS
@onready
var background: Sprite2D = $Background

@onready
var settings: SettingsPanel = %Settings

@onready
var inner_ui_body: MarginContainer = $UI/Settings/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer/InnerCircle/CategoryBody

@onready
var inner_line_color_picker: ColorPickerButton = %InnerLineColorButton

@onready
var inner_double_button: CheckButton = %InnDoubleButton

@onready
var inner_radius_slider: HSlider = %InnRadiusSlider

@onready
var inner_spacing_slider: HSlider = %InnSpacingSlider

@onready
var inner_rings_number_slider: HSlider = %InnRingsNumberSlider

@onready
var inner_rings_radius_ui: VBoxContainer = $UI/Settings/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer/InnerCircle/CategoryBody/VBoxContainer/Rings/SubCategoryBody/VBoxContainer/Radius

@onready
var inner_rings_radius_slider: HSlider = %InnRingsRadiusSlider

@onready
var inner_rings_offset_ui: VBoxContainer = $UI/Settings/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer/InnerCircle/CategoryBody/VBoxContainer/Rings/SubCategoryBody/VBoxContainer/Offset

@onready
var inner_rings_offset_slider: HSlider = %InnRingsOffsetSlider

@onready
var outer_ui_body: MarginContainer = $UI/Settings/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer/OuterCircle/CategoryBody

@onready
var outer_line_color_picker: ColorPickerButton = %OuterLineColorButton

@onready
var outer_double_button: CheckButton = %OutDoubleButton

@onready
var outer_radius_slider: HSlider = %OutRadiusSlider

@onready
var outer_spacing_slider: HSlider = %OutSpacingSlider

@onready
var outer_rings_number_slider: HSlider = %OutRingsNumberSlider

@onready
var outer_rings_radius_ui: VBoxContainer = $UI/Settings/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer/OuterCircle/CategoryBody/VBoxContainer/Rings/SubCategoryBody/VBoxContainer/Radius

@onready
var outer_rings_radius_slider: HSlider = %OutRingsRadiusSlider

@onready
var outer_rings_offset_ui: VBoxContainer = $UI/Settings/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer/OuterCircle/CategoryBody/VBoxContainer/Rings/SubCategoryBody/VBoxContainer/Offset

@onready
var outer_rings_offset_slider: HSlider = %OutRingsOffsetSlider

@onready
var renderer: MagicCircleRenderer = $MagicCircleRenderer
#endregion

func _ready() -> void:
	# Center objects on screen
	background.scale = Vector2(3, 2)
	background.position = get_viewport_rect().get_center()
	renderer.position = get_viewport_rect().get_center()

	#region STARTUP UI SETTINGS
	inner_radius_slider.min_value = Constants.INNER_CIRCLE_RADIUS_MIN
	inner_radius_slider.max_value = Constants.INNER_CIRCLE_RADIUS_MAX
	inner_spacing_slider.min_value = Constants.INNER_CIRCLE_SPACING_MIN
	inner_spacing_slider.max_value = Constants.INNER_CIRCLE_SPACING_MAX
	inner_rings_number_slider.min_value = Constants.INNER_CIRCLE_RINGS_MIN
	inner_rings_number_slider.max_value = Constants.INNER_CIRCLE_RINGS_MAX
	inner_rings_radius_slider.min_value = Constants.INNER_CIRCLE_RINGS_RADIUS_MIN
	inner_rings_radius_slider.max_value = Constants.INNER_CIRCLE_RINGS_RADIUS_MAX
	inner_rings_offset_slider.max_value = 360

	outer_radius_slider.min_value = Constants.OUTER_CIRCLE_RADIUS_MIN
	outer_radius_slider.max_value = Constants.OUTER_CIRCLE_RADIUS_MAX
	outer_spacing_slider.min_value = Constants.OUTER_CIRCLE_SPACING_MIN
	outer_spacing_slider.max_value = Constants.OUTER_CIRCLE_SPACING_MAX
	outer_rings_number_slider.min_value = Constants.OUTER_CIRCLE_RINGS_MIN
	outer_rings_number_slider.max_value = Constants.OUTER_CIRCLE_RINGS_MAX
	outer_rings_radius_slider.min_value = Constants.OUTER_CIRCLE_RINGS_RADIUS_MIN
	outer_rings_radius_slider.max_value = Constants.OUTER_CIRCLE_RINGS_RADIUS_MAX
	outer_rings_offset_slider.max_value = 360
	#endregion

	# Generate a new circle
	reset()

func _process(_delta: float) -> void:
	# Close the game
	if Input.is_action_just_released("quit"):
		get_tree().quit()

	# Generate a new circle
	if Input.is_action_just_released("reset"):
		reset()

func reset():
	var circle: MagicCircle = MagicCircleGenerator.generate()
	var color: Color = Color(randf(), randf(), randf(), 1)

	renderer.set_data.emit(circle)
	renderer.set_inner_line_color.emit(color)
	renderer.set_outer_line_color.emit(color)

	#region UPDATE UI CONTROLS
	# Section: general
	settings.update_background_color.emit( color/2 )
	update_background_color( color/2 )

	# Section: inner circle
	inner_line_color_picker.color = color
	inner_radius_slider.value = circle.inner.radius
	inner_double_button.button_pressed = circle.inner.double
	update_inner_spacing_slider_visibility(circle.inner.double)
	inner_spacing_slider.value = circle.inner.spacing
	inner_rings_number_slider.value = circle.inner.rings
	update_inner_rings_controls_visibility(true if circle.inner.rings else false)
	inner_rings_radius_slider.value = circle.inner.rings_radius
	inner_rings_offset_slider.value = snappedf(rad_to_deg(circle.inner.rings_offset_rad), 0.01)

	# Section: outer circle
	outer_line_color_picker.color = color
	outer_radius_slider.value = circle.outer.radius
	outer_double_button.button_pressed = circle.outer.double
	update_outer_spacing_slider_visibility(circle.outer.double)
	outer_spacing_slider.value = circle.outer.spacing
	outer_rings_number_slider.value = circle.outer.rings
	update_outer_rings_controls_visibility(true if circle.outer.rings else false)
	outer_rings_radius_slider.value = circle.outer.rings_radius
	outer_rings_offset_slider.value = snappedf(rad_to_deg(circle.outer.rings_offset_rad), 0.01)
	#endregion

#region CUSTOM UI UPDATE FUNCTIONS
func update_background_color(color: Color):
	background.material.set_shader_parameter("background_color", color)

func update_inner_spacing_slider_visibility(visibility: bool):
	%InnerDoubleSpacing.visible = visibility

func update_inner_rings_controls_visibility(visibility: bool):
	inner_rings_radius_ui.visible = visibility
	inner_rings_offset_ui.visible = visibility

func update_outer_spacing_slider_visibility(visibility: bool):
	%OuterDoubleSpacing.visible = visibility

func update_outer_rings_controls_visibility(visibility: bool):
	outer_rings_radius_ui.visible = visibility
	outer_rings_offset_ui.visible = visibility
#endregion

#region SIGNALS
func _on_inner_circle_toggle_toggled(toggled_on: bool) -> void:
	renderer.set_inner_draw_toggle.emit(toggled_on)
	inner_ui_body.visible = toggled_on

func _on_inner_line_color_button_color_changed(color: Color) -> void:
	renderer.set_inner_line_color.emit(color)

func _on_inn_radius_slider_value_changed(value: float) -> void:
	renderer.set_inner_radius.emit(value)

func _on_inn_double_button_toggled(toggled_on: bool) -> void:
	renderer.set_inner_double.emit(toggled_on)
	update_inner_spacing_slider_visibility(toggled_on)

func _on_inn_spacing_slider_value_changed(value: float) -> void:
	renderer.set_inner_spacing.emit(value)

func _on_inn_rings_number_slider_value_changed(value: float) -> void:
	renderer.set_inner_rings_number.emit(value)
	update_inner_rings_controls_visibility(true if value else false)

func _on_inn_rings_radius_slider_value_changed(value: float) -> void:
	renderer.set_inner_rings_radius.emit(value)

func _on_inn_rings_offset_slider_value_changed(value: float) -> void:
	renderer.set_inner_rings_offset.emit(deg_to_rad(value))

func _on_outer_circle_toggle_toggled(toggled_on: bool) -> void:
	renderer.set_outer_draw_toggle.emit(toggled_on)
	outer_ui_body.visible = toggled_on

func _on_outer_line_color_button_color_changed(color: Color) -> void:
	renderer.set_outer_line_color.emit(color)

func _on_out_radius_slider_value_changed(value: float) -> void:
	renderer.set_outer_radius.emit(value)

func _on_out_double_button_toggled(toggled_on: bool) -> void:
	renderer.set_outer_double.emit(toggled_on)
	update_outer_spacing_slider_visibility(toggled_on)

func _on_out_spacing_slider_value_changed(value: float) -> void:
	renderer.set_outer_spacing.emit(value)

func _on_out_rings_number_slider_value_changed(value: float) -> void:
	renderer.set_outer_rings_number.emit(value)
	update_outer_rings_controls_visibility(true if value else false)

func _on_out_rings_radius_slider_value_changed(value: float) -> void:
	renderer.set_outer_rings_radius.emit(value)

func _on_out_rings_offset_slider_value_changed(value: float) -> void:
	renderer.set_outer_rings_offset.emit(deg_to_rad(value))
#endregion

# TMP NEW HANDLERS
func _on_settings_background_color_changed(color: Color) -> void:
	update_background_color(color)
