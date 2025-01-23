class_name MagicDisk extends RefCounted

# Main disk
var enabled: bool

var radius: float

var line_color: Color
var double: bool # Single or double line
var spacing: int # Double line spacing

# Rings embedded in the main disk
var rings: int
var rings_enabled: bool
var rings_radius: int
var rings_distance_rad: float # Circular sector angle between two points in radians (distance)
var rings_offset_rad: float # Circular sector offset in radians
