extends Node2D

#region ONREADY PROPS
@onready
var background: Sprite2D = $Background

@onready
var color_picker: ColorPickerButton = %ColorPickerButton

@onready
var double_button_in: CheckButton = %DoubleButtonIn

@onready
var double_button_out: CheckButton = %DoubleButtonOut

@onready
var radius_slider_in: HSlider = %RadiusSliderIn

@onready
var radius_slider_out: HSlider = %RadiusSliderOut

@onready
var spacing_slider_in: HSlider = %SpacingSliderIn

@onready
var spacing_slider_out: HSlider = %SpacingSliderOut

@onready
var renderer: MagicCircleRenderer = $MagicCircleRenderer
#endregion

func _ready() -> void:
	# Center objects on screen
	background.scale = Vector2(3, 2)
	background.position = get_viewport_rect().get_center()
	renderer.position = get_viewport_rect().get_center()
	#region STARTUP SETTINGS
	radius_slider_in.min_value = Constants.INNER_CIRCLE_RADIUS_MIN
	radius_slider_in.max_value = Constants.INNER_CIRCLE_RADIUS_MAX
	radius_slider_out.min_value = Constants.OUTER_CIRCLE_RADIUS_MIN
	radius_slider_out.max_value = Constants.OUTER_CIRCLE_RADIUS_MAX
	spacing_slider_in.min_value = Constants.INNER_CIRCLE_SPACING_MIN
	spacing_slider_in.max_value = Constants.INNER_CIRCLE_SPACING_MAX
	spacing_slider_out.min_value = Constants.OUTER_CIRCLE_SPACING_MIN
	spacing_slider_out.max_value = Constants.OUTER_CIRCLE_SPACING_MAX
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

func update_color(color: Color):
	renderer.set_color(color)
	# Match background and circle color, using a lighter shade for the bg
	background.material.set_shader_parameter("background_color", color / 2)
	# Set color picker value
	color_picker.color = color

func reset():
	var circle: MagicCircle = MagicCircleGenerator.generate()
	var color: Color = Color(randf(), randf(), randf(), 1)

	renderer.set_data.emit(circle)

	# Update inner circle controls
	radius_slider_in.value = circle.inner.radius
	double_button_in.button_pressed = circle.inner.double
	spacing_slider_in.value = circle.inner.spacing

	# Update outer circle controls
	radius_slider_out.value = circle.outer.radius
	double_button_out.button_pressed = circle.outer.double
	spacing_slider_out.value = circle.outer.spacing

	update_color(color)

#region SIGNALS
func _on_color_picker_button_color_changed(color: Color) -> void:
	update_color(color)

func _on_radius_slider_in_value_changed(value: float) -> void:
	renderer.set_inner_radius.emit(value)

func _on_double_button_in_toggled(toggled_on: bool) -> void:
	renderer.set_inner_double.emit(toggled_on)

func _on_spacing_slider_in_value_changed(value: float) -> void:
	renderer.set_inner_spacing.emit(value)

func _on_radius_slider_out_value_changed(value: float) -> void:
	renderer.set_outer_radius.emit(value)

func _on_double_button_out_toggled(toggled_on: bool) -> void:
	renderer.set_outer_double.emit(toggled_on)

func _on_spacing_slider_out_value_changed(value: float) -> void:
	renderer.set_outer_spacing.emit(value)
#endregion
