extends Node2D


#region ONREADY PROPS
@onready
var background: Sprite2D = $Background

@onready
var renderer: MagicCircleRenderer = $MagicCircleRenderer

@onready
var settings: SettingsPanel = %SettingsPanel
#endregion


func _ready() -> void:
	# Center objects on screen
	background.scale = Vector2(3, 2)
	background.position = get_viewport_rect().get_center()
	renderer.position = get_viewport_rect().get_center()

	#region CONNECTIONS
	# General
	EventBus.background_color_bottom.connect(_on_background_color_bottom)

	# Inner circle
	EventBus.inner_circle_toggle_bottom.connect(_on_inner_circle_toggle_bottom)
	EventBus.inner_circle_radius_bottom.connect(_on_inner_circle_radius_bottom)
	EventBus.inner_circle_line_color_bottom.connect(_on_inner_circle_line_color_bottom)
	EventBus.inner_circle_double_line_toggle_bottom.connect(_on_inner_circle_double_line_toggle_bottom)
	EventBus.inner_circle_double_line_spacing_bottom.connect(_on_inner_circle_double_line_spacing_bottom)
	EventBus.inner_circle_rings_toggle_bottom.connect(_on_inner_circle_rings_toggle_bottom)
	EventBus.inner_circle_rings_number_bottom.connect(_on_inner_circle_rings_number_bottom)
	EventBus.inner_circle_rings_radius_bottom.connect(_on_inner_circle_rings_radius_bottom)
	EventBus.inner_circle_rings_offset_bottom.connect(_on_inner_circle_rings_offset_bottom)

	# Outer circle
	EventBus.outer_circle_toggle_bottom.connect(_on_outer_circle_toggle_bottom)
	EventBus.outer_circle_radius_bottom.connect(_on_outer_circle_radius_bottom)
	EventBus.outer_circle_line_color_bottom.connect(_on_outer_circle_line_color_bottom)
	EventBus.outer_circle_double_line_toggle_bottom.connect(_on_outer_circle_double_line_toggle_bottom)
	EventBus.outer_circle_double_line_spacing_bottom.connect(_on_outer_circle_double_line_spacing_bottom)
	EventBus.outer_circle_rings_toggle_bottom.connect(_on_outer_circle_rings_toggle_bottom)
	EventBus.outer_circle_rings_number_bottom.connect(_on_outer_circle_rings_number_bottom)
	EventBus.outer_circle_rings_radius_bottom.connect(_on_outer_circle_rings_radius_bottom)
	EventBus.outer_circle_rings_offset_bottom.connect(_on_outer_circle_rings_offset_bottom)
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

	# Update renderer data
	renderer.set_data.emit(circle)
	renderer.set_inner_line_color.emit(color)
	renderer.set_outer_line_color.emit(color)

	#region UPDATE UI
	EventBus.background_color_top.emit( color/2 ) 	# Update UI
	_on_background_color_bottom( color/2 )			# Update scene

	# TODO update draw toggle UI control
	EventBus.inner_circle_toggle_top.emit(circle.inner.enabled)
	EventBus.inner_circle_radius_top.emit(circle.inner.radius)
	EventBus.inner_circle_line_color_top.emit(color)
	EventBus.inner_circle_double_line_toggle_top.emit(circle.inner.double)
	EventBus.inner_circle_double_line_spacing_top.emit(circle.inner.spacing)
	EventBus.inner_circle_rings_toggle_top.emit(circle.inner.rings_enabled)
	EventBus.inner_circle_rings_number_top.emit(circle.inner.rings)
	EventBus.inner_circle_rings_radius_top.emit(circle.inner.rings_radius)
	EventBus.inner_circle_rings_offset_top.emit(snappedf(rad_to_deg(circle.inner.rings_offset_rad), 1))

	EventBus.outer_circle_toggle_top.emit(circle.outer.enabled)
	EventBus.outer_circle_radius_top.emit(circle.outer.radius)
	EventBus.outer_circle_line_color_top.emit(color)
	EventBus.outer_circle_double_line_toggle_top.emit(circle.outer.double)
	EventBus.outer_circle_double_line_spacing_top.emit(circle.outer.spacing)
	EventBus.outer_circle_rings_toggle_top.emit(circle.outer.rings_enabled)
	EventBus.outer_circle_rings_number_top.emit(circle.outer.rings)
	EventBus.outer_circle_rings_radius_top.emit(circle.outer.rings_radius)
	EventBus.outer_circle_rings_offset_top.emit(snappedf(rad_to_deg(circle.outer.rings_offset_rad), 1))
	#endregion


#region SIGNAL HANDLERS
# General
func _on_background_color_bottom(color: Color):
	background.material.set_shader_parameter("background_color", color)

# Inner circle
func _on_inner_circle_toggle_bottom(toggled_on: bool) -> void:
	renderer.set_inner_visibility.emit(toggled_on)

func _on_inner_circle_radius_bottom(value: float) -> void:
	renderer.set_inner_radius.emit(value)

func _on_inner_circle_line_color_bottom(color: Color) -> void:
	renderer.set_inner_line_color.emit(color)

func _on_inner_circle_double_line_toggle_bottom(toggled_on: bool) -> void:
	renderer.set_inner_double.emit(toggled_on)

func _on_inner_circle_double_line_spacing_bottom(value: float) -> void:
	renderer.set_inner_spacing.emit(value)

func _on_inner_circle_rings_toggle_bottom(toggled_on: bool) -> void:
	renderer.set_inner_rings_visibility.emit(toggled_on)

func _on_inner_circle_rings_number_bottom(value: float) -> void:
	renderer.set_inner_rings_number.emit(value)

func _on_inner_circle_rings_radius_bottom(value: float) -> void:
	renderer.set_inner_rings_radius.emit(value)

func _on_inner_circle_rings_offset_bottom(value: float) -> void:
	renderer.set_inner_rings_offset.emit(deg_to_rad(value))

# Outer circle
func _on_outer_circle_toggle_bottom(toggled_on: bool) -> void:
	renderer.set_outer_visibility.emit(toggled_on)

func _on_outer_circle_radius_bottom(value: float) -> void:
	renderer.set_outer_radius.emit(value)

func _on_outer_circle_line_color_bottom(color: Color) -> void:
	renderer.set_outer_line_color.emit(color)

func _on_outer_circle_double_line_toggle_bottom(toggled_on: bool) -> void:
	renderer.set_outer_double.emit(toggled_on)

func _on_outer_circle_double_line_spacing_bottom(value: float) -> void:
	renderer.set_outer_spacing.emit(value)

func _on_outer_circle_rings_toggle_bottom(toggled_on: bool) -> void:
	renderer.set_outer_rings_visibility.emit(toggled_on)

func _on_outer_circle_rings_number_bottom(value: float) -> void:
	renderer.set_outer_rings_number.emit(value)

func _on_outer_circle_rings_radius_bottom(value: float) -> void:
	renderer.set_outer_rings_radius.emit(value)

func _on_outer_circle_rings_offset_bottom(value: float) -> void:
	renderer.set_outer_rings_offset.emit(deg_to_rad(value))
#endregion
