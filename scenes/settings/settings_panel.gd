class_name SettingsPanel extends Control

#region SIGNALS
signal background_color_changed(color: Color)
signal update_background_color(color: Color)
#endregion

#region ONREADY PROPS
#endregion

#region SIGNALS HANDLERS
func _on_background_color_picker_button_color_changed(color: Color) -> void:
	background_color_changed.emit(color)
func _on_update_background_color(color: Color) -> void:
	%BackgroundColorPickerButton.color = color
#endregion
