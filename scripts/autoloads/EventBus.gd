extends Node

## LEGEND
##
## "signal_name"_bottom => bottom-up: information travels from UI to the generator
## "signal_name"_top    => top-down: information travels from the generator to the UI

#region DATA SIGNALS
# Background color
signal background_color_bottom(color: Color)
signal background_color_top(color: Color)

# Section toggle
signal inner_circle_toggle_bottom(toggled_on: bool)
signal inner_circle_toggle_top(toggled_on: bool)
signal outer_circle_toggle_bottom(toggled_on: bool)
signal outer_circle_toggle_top(toggled_on: bool)

# Radius
signal inner_circle_radius_bottom(value: float)
signal inner_circle_radius_top(value: float)
signal outer_circle_radius_bottom(value: float)
signal outer_circle_radius_top(value: float)

# Line color
signal inner_circle_line_color_bottom(color: Color)
signal inner_circle_line_color_top(color: Color)
signal outer_circle_line_color_bottom(color: Color)
signal outer_circle_line_color_top(color: Color)

# Double line
signal inner_circle_double_line_toggle_bottom(toggled_on: bool)
signal inner_circle_double_line_toggle_top(toggled_on: bool)
signal outer_circle_double_line_toggle_bottom(toggled_on: bool)
signal outer_circle_double_line_toggle_top(toggled_on: bool)

# Double line spacing
signal inner_circle_double_line_spacing_bottom(value: float)
signal inner_circle_double_line_spacing_top(value: float)
signal outer_circle_double_line_spacing_bottom(value: float)
signal outer_circle_double_line_spacing_top(value: float)

# Rings toggle
signal inner_circle_rings_toggle_bottom(toggled_on: bool)
signal inner_circle_rings_toggle_top(toggled_on: bool)
signal outer_circle_rings_toggle_bottom(toggled_on: bool)
signal outer_circle_rings_toggle_top(toggled_on: bool)

# Rings number
signal inner_circle_rings_number_bottom(value: float)
signal inner_circle_rings_number_top(value: float)
signal outer_circle_rings_number_bottom(value: float)
signal outer_circle_rings_number_top(value: float)

# Rings radius
signal inner_circle_rings_radius_bottom(value: float)
signal inner_circle_rings_radius_top(value: float)
signal outer_circle_rings_radius_bottom(value: float)
signal outer_circle_rings_radius_top(value: float)

# Rings offset
signal inner_circle_rings_offset_bottom(value: float)
signal inner_circle_rings_offset_top(value: float)
signal outer_circle_rings_offset_bottom(value: float)
signal outer_circle_rings_offset_top(value: float)
#endregion
