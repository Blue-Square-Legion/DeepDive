shader_type canvas_item;

uniform bool toggle_outline = false;
uniform bool toggle_alpha = false;

uniform float line_width = 10.0;
uniform vec4 outline_color = vec4(0.0, 0.0, 0.0, 1.0);

const float pi = 3.14159;
const int ang_res = 8;

void fragment() {
	if (toggle_alpha){
		vec4 tex_color = texture(TEXTURE, UV);

		tex_color.a = 0.0;
		COLOR = tex_color;
	}
	if (toggle_outline){
		float alpha = 0.0;
		vec2 scale = TEXTURE_PIXEL_SIZE;

		for (int i = 0; i < ang_res; i++) {
			float angle = 2.0 * pi * float(i) / float(ang_res);
			vec2 disp = scale * line_width * vec2(cos(angle), sin(angle));
			alpha += texture(TEXTURE, UV + disp).a;
		}

		if (alpha > 0.0 && texture(TEXTURE, UV).a == 0.0) {
			COLOR = outline_color;
		}
		else {
			COLOR = texture(TEXTURE, UV);
		}
	}
}
