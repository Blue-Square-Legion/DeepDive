shader_type canvas_item;

uniform bool toggle_silouette = false;

void fragment() {
	if (toggle_silouette) {
		vec4 tex_color = texture(TEXTURE, UV);

		if (tex_color.a < 0.1) {
			discard;
		}

		COLOR = vec4(0.0, 0.0, 0.0, tex_color.a);
	}
}
