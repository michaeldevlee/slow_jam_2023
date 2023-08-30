extends TextureButton



func _on_Slide_Out_Button_mouse_entered():
	material.set_shader_param("Color", Color(1,1,1, 0.5))
